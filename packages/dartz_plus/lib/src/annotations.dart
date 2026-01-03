part of '../dartz_plus.dart';

///
/// Use this annotation to generate mapping extension methods for data classes.
///
/// Usage:
/// ```dart
/// @Mapper(UserModel)
/// class User { ... }
/// ```
///
/// This will generate a `toUserModel()` extension method on the `User` class.
class Mapper {
  /// Creates a Mapper annotation.
  ///
  /// [target] is the Type of the class you want to map TO.
  /// [reverse] if true, generates a reverse mapping method (Target -> Source).
  /// [constructor] the name of the target constructor to use.
  const Mapper(this.target, {this.reverse = true, this.constructor});

  /// The target type to map to.
  ///
  /// If provided, an extension method `toTarget()` will be generated on the annotated class.
  final Type target;

  /// Whether to generate the reverse mapping (Target -> Source).
  final bool reverse;

  /// The name of the target class constructor to use.
  /// If null, the default (unnamed) constructor is used.
  final String? constructor;
}

///
/// Annotation to map a source field to a target field with a different name.
///
class MapTo {
  /// Creates a MapTo annotation.
  const MapTo(this.name);

  /// The name of the target field this field maps to.
  final String name;
}

///
/// Annotation to ignore a field during mapping.
///
class IgnoreMap {
  /// Creates an IgnoreMap annotation.
  const IgnoreMap();
}
