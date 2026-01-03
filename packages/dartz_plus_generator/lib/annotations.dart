/// Annotation to mark a class as a Mapper.
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
  const Mapper(this.target, {this.reverse = true});

  /// The target type to map to.
  ///
  /// If provided, an extension method `toTarget()` will be generated on the annotated class.
  final Type target;

  /// Whether to generate the reverse mapping (Target -> Source).
  final bool reverse;
}
