/// Annotation to mark a class as a Mapper.
///
/// Use this annotation to generate mapping extension methods for data classes.
///
/// Usage:
/// ```dart
/// @Mapper(UserDto)
/// class User { ... }
/// ```
///
/// This will generate a `toUserDto()` extension method on the `User` class.
class Mapper {
  /// Creates a Mapper annotation.
  ///
  /// [target] is the Type of the class you want to map TO.
  const Mapper(this.target);

  /// The target type to map to.
  ///
  /// If provided, an extension method `toTarget()` will be generated on the annotated class.
  final Type target;
}
