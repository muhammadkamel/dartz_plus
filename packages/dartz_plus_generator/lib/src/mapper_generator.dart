import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:dartz_plus_generator/annotations.dart';
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
        'Mapper must have a target type. Example: @Mapper(UserDto)',
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

    // 1. Forward Mapping: Annotated Class -> Target Type
    _generateMapping(element, targetElement, buffer);

    // 2. Reverse Mapping: Target Type -> Annotated Class
    final bool reverse = annotation.peek('reverse')?.boolValue ?? true;
    if (reverse) {
      _generateMapping(targetElement, element, buffer);
    }

    return buffer.toString();
  }

  void _generateMapping(
    ClassElement source,
    ClassElement target,
    StringBuffer buffer,
  ) {
    final String sourceName = source.name ?? '';
    final String targetName = target.name ?? '';
    final extensionName = '${sourceName}To${targetName}Mapper';

    buffer.writeln('extension $extensionName on $sourceName {');
    buffer.writeln('  $targetName to$targetName() {');
    buffer.writeln('    return $targetName(');

    final ConstructorElement? constructor = target.unnamedConstructor;
    if (constructor == null) {
      throw InvalidGenerationSourceError(
        'Target class $targetName must have a default (unnamed) constructor.',
        element: target,
      );
    }

    final List<FieldElement> sourceFields = getAllFields(source);

    for (final FormalParameterElement param in constructor.formalParameters) {
      final String paramName = param.name ?? '';

      // Find matching field in source
      final FieldElement? matchingField = sourceFields.firstWhereOrNull(
        (f) => f.name == paramName,
      );

      if (matchingField == null) {
        // Smart Field Resolution:
        // If the parameter is optional or nullable, we can skip it.
        // It will use its default value or null.
        if (param.isOptional ||
            param.type.nullabilitySuffix != NullabilitySuffix.none) {
          continue;
        }

        throw InvalidGenerationSourceError(
          'Could not find matching field for required parameter "$paramName" in $sourceName while mapping to $targetName',
          element: source,
        );
      }

      if (!param.isNamed) {
        buffer.writeln('      ${matchingField.name},');
      } else {
        buffer.writeln('      $paramName: ${matchingField.name},');
      }
    }

    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
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
