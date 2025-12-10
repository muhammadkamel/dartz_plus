import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:dartz_plus/dartz_plus.dart'; // For AutoMap annotation reference (optional, usually string check is safer/easier)
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

    final buffer = StringBuffer();
    final String className = element.name!;
    final String targetName = targetType.getDisplayString();
    final extensionName = '${className}To${targetName}Mapper';

    buffer.writeln('extension $extensionName on $className {');
    buffer.writeln('  $targetName to$targetName() {');
    buffer.writeln('    return $targetName(');

    final targetElement = targetType.element as ClassElement?;
    if (targetElement == null) {
      throw InvalidGenerationSourceError('Target type must be a class',
          element: element);
    }

    final ConstructorElement? constructor = targetElement.unnamedConstructor;
    if (constructor == null) {
      throw InvalidGenerationSourceError(
        'Target class ${targetElement.name} must have a default (unnamed) constructor.',
        element: targetElement,
      );
    }

    final List<FieldElement> sourceFields = getAllFields(element);

    // Access constructor parameters
    for (final FormalParameterElement param in constructor.formalParameters) {
      final String paramName = param.name!;
      // Find matching field in source
      final FieldElement matchingField = sourceFields.firstWhere(
        (f) => f.name == paramName,
        orElse: () => throw InvalidGenerationSourceError(
          'Could not find matching field for "$paramName" in $className',
          element: element,
        ),
      );

      if (!param.isNamed) {
        buffer.writeln('      ${matchingField.name},');
      } else {
        buffer.writeln('      $paramName: ${matchingField.name},');
      }
    }

    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    return buffer.toString();
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
