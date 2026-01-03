import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:dartz_plus/dartz_plus.dart';
import 'package:source_gen/source_gen.dart';

/// Generator for @Mapper annotations.
///
/// Generates implementations for abstract mapper classes.
class MapperGenerator extends GeneratorForAnnotation<Mapper> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@Mapper can only be applied to classes.',
        element: element,
      );
    }

    DartType? targetType;
    // 1. Try reading as named field 'target'
    final ConstantReader? targetReader = annotation.peek('target');
    if (targetReader != null && !targetReader.isNull) {
      targetType = targetReader.typeValue;
    }

    // 2. Try reading as first positional argument (since we made it required positional)
    if (targetType == null) {
      final Revivable revived = annotation.revive();
      if (revived.positionalArguments.isNotEmpty) {
        final DartObject arg = revived.positionalArguments.first;
        // Check if arg is DartObject or already refined
        targetType = ConstantReader(arg).typeValue;
      }
    }

    if (targetType == null) {
      throw InvalidGenerationSourceError(
        'Mapper must have a target type. Example: @Mapper(UserModel)',
        element: element,
      );
    }

    final Element? targetElement = targetType.element;
    if (targetElement is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Target type must be a class',
        element: element,
      );
    }

    final buffer = StringBuffer();
    final String? constructorName = annotation.peek('constructor')?.stringValue;

    // 1. Forward Mapping: Annotated Class -> Target Type
    _generateMapping(element, targetElement, buffer, constructorName);

    // 2. Reverse Mapping: Target Type -> Annotated Class
    final bool reverse = annotation.peek('reverse')?.boolValue ?? true;
    if (reverse) {
      // For reverse mapping, we don't necessarily use the same constructor name
      // since the original source might not have that specific constructor.
      // We'll stick to default for now, unless we want to add 'reverseConstructor'.
      _generateMapping(targetElement, element, buffer, null);
    }

    return buffer.toString();
  }

  void _generateMapping(
    ClassElement source,
    ClassElement target,
    StringBuffer buffer,
    String? constructorName,
  ) {
    final String sourceName = source.name!;
    final String targetName = target.name!;
    final extensionName = '${sourceName}To${targetName}Mapper';

    buffer.writeln('extension $extensionName on $sourceName {');
    buffer.writeln('  $targetName to$targetName() {');

    final ConstructorElement? constructor = constructorName != null
        ? target.getNamedConstructor(constructorName)
        : target.unnamedConstructor;

    if (constructor == null) {
      final msg = constructorName != null
          ? 'Target class $targetName must have a constructor named "$constructorName".'
          : 'Target class $targetName must have a default (unnamed) constructor.';
      throw InvalidGenerationSourceError(msg, element: target);
    }

    final String constructorInvocation = constructorName != null
        ? '$targetName.$constructorName'
        : targetName;

    buffer.writeln('    return $constructorInvocation(');

    final List<FieldElement> sourceFields = getAllFields(source);
    final List<FormalParameterElement> sourceParams =
        source.unnamedConstructor?.formalParameters ?? [];

    for (final FormalParameterElement param in constructor.formalParameters) {
      final String paramName = param.name!;

      // Find matching field or param in source
      // We also pass targetFields to allow "reverse lookup" of @MapTo
      final sourceInfo = _resolveSourceField(
        paramName,
        sourceFields,
        sourceParams,
        target,
      );

      String? sourceAccess;
      DartType? sourceType;

      if (sourceInfo != null) {
        sourceAccess = sourceInfo.name;
        sourceType = sourceInfo.type;
      }

      if (sourceAccess == null) {
        if (param.isOptional ||
            param.type.nullabilitySuffix != NullabilitySuffix.none) {
          continue;
        }

        throw InvalidGenerationSourceError(
          'Could not find matching field or constructor parameter for required parameter "$paramName" in $sourceName while mapping to $targetName',
          element: source,
        );
      }

      // Handle List conversion
      if (sourceType != null &&
          sourceType.isDartCoreList &&
          param.type.isDartCoreList) {
        final sourceListType = sourceType as InterfaceType;
        final targetListType = param.type as InterfaceType;

        if (sourceListType.typeArguments.isNotEmpty &&
            targetListType.typeArguments.isNotEmpty) {
          final sourceArg = sourceListType.typeArguments.first;
          final targetArg = targetListType.typeArguments.first;

          if (sourceArg != targetArg) {
            final targetArgName = targetArg.element?.name;
            if (targetArgName != null) {
              final isNullable =
                  sourceListType.nullabilitySuffix != NullabilitySuffix.none;
              final access = isNullable ? '$sourceAccess?' : sourceAccess;
              sourceAccess =
                  '$access.map((e) => e.to$targetArgName()).toList()';
            }
          }
        }
      } else if (sourceType != null &&
          sourceType != param.type &&
          sourceType.element?.name != param.type.element?.name) {
        // Handle single object nested mapping
        final targetTypeName = param.type.element?.name;
        if (targetTypeName != null) {
          final isNullable =
              sourceType.nullabilitySuffix != NullabilitySuffix.none;
          sourceAccess = isNullable
              ? '$sourceAccess?.to$targetTypeName()'
              : '$sourceAccess.to$targetTypeName()';
        }
      }

      if (!param.isNamed) {
        buffer.writeln('      $sourceAccess,');
      } else {
        buffer.writeln('      $paramName: $sourceAccess,');
      }
    }

    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
  }

  _SourceInfo? _resolveSourceField(
    String targetName,
    List<FieldElement> fields,
    List<FormalParameterElement> params,
    ClassElement targetClass,
  ) {
    // We check for annotations from both dartz_plus and dartz_plus_generator
    // to handle different import styles and internal example usage.
    final mapToChecker = const TypeChecker.any([
      TypeChecker.fromUrl('package:dartz_plus/dartz_plus.dart#MapTo'),
      TypeChecker.fromUrl(
        'package:dartz_plus_generator/annotations.dart#MapTo',
      ),
    ]);
    final ignoreChecker = const TypeChecker.any([
      TypeChecker.fromUrl('package:dartz_plus/dartz_plus.dart#IgnoreMap'),
      TypeChecker.fromUrl(
        'package:dartz_plus_generator/annotations.dart#IgnoreMap',
      ),
    ]);

    // 1. Check fields for @MapTo or direct name match
    for (final field in fields) {
      if (ignoreChecker.hasAnnotationOfExact(field)) continue;

      final mapToAnnotation = mapToChecker.firstAnnotationOfExact(field);
      if (mapToAnnotation != null) {
        final mappedName = mapToAnnotation.getField('name')?.toStringValue();
        if (mappedName == targetName) {
          return _SourceInfo(field.name!, field.type);
        }
      } else if (field.name == targetName) {
        // Only match if it doesn't have a different @MapTo
        final otherMapTo = mapToChecker.firstAnnotationOfExact(field);
        if (otherMapTo == null) {
          return _SourceInfo(field.name!, field.type);
        }
      }
    }

    // 2. Check constructor parameters for @MapTo or direct name match
    for (final param in params) {
      if (ignoreChecker.hasAnnotationOfExact(param)) continue;

      final mapToAnnotation = mapToChecker.firstAnnotationOfExact(param);
      if (mapToAnnotation != null) {
        final mappedName = mapToAnnotation.getField('name')?.toStringValue();
        if (mappedName == targetName) {
          return _SourceInfo(param.name!, param.type);
        }
      } else if (param.name == targetName) {
        // Only match if it doesn't have a different @MapTo
        final otherMapTo = mapToChecker.firstAnnotationOfExact(param);
        if (otherMapTo == null) {
          return _SourceInfo(param.name!, param.type);
        }
      }
    }

    // 3. Reverse Lookup: Check the TARGET class fields for @MapTo that points TO this source field
    // This allows single-side @MapTo to work bidirectionally.
    final targetFields = getAllFields(targetClass);
    for (final targetField in targetFields) {
      final mapToAnnotation = mapToChecker.firstAnnotationOfExact(targetField);
      if (mapToAnnotation != null) {
        final mappedName = mapToAnnotation.getField('name')?.toStringValue();
        // If the target field says "@MapTo('name')", and we are looking for 'name' in source
        if (targetField.name == targetName) {
          // We need to find the source field that corresponds to mappedName
          for (final f in fields) {
            if (f.name == mappedName) return _SourceInfo(f.name!, f.type);
          }
        }
      }
    }

    return null;
  }

  /// recursively retrieves fields from the class and its superclasses
  List<FieldElement> getAllFields(ClassElement element) {
    final fields = <FieldElement>[];

    // Get fields from the class and its superclasses
    var current = element;
    while (true) {
      fields.addAll(current.fields.where((f) => !f.isStatic));

      final InterfaceType? supertype = current.supertype;
      if (supertype == null || supertype.isDartCoreObject) {
        break;
      }

      final superElement = supertype.element as ClassElement?;
      if (superElement == null) {
        break;
      }
      current = superElement;
    }

    return fields;
  }
}

class _SourceInfo {
  final String name;
  final DartType type;
  _SourceInfo(this.name, this.type);
}
