# Changelog

All notable changes to this project will be documented in this file.

## [0.0.1] - 2024-12-XX

### Added

- Initial release of `dartz_plus`
- `Either<L, R>` sealed class for representing disjoint union types
- `Left<L, R>` class representing the left side (typically errors/failures)
- `Right<L, R>` class representing the right side (typically success values)
- Factory constructors:
  - `Either.left(L value)` - Creates a `Left` instance
  - `Either.right(R value)` - Creates a `Right` instance
- Getters:
  - `isLeft` - Returns `true` if this is a `Left` instance
  - `isRight` - Returns `true` if this is a `Right` instance
  - `leftValue` - Returns the left value if this is a `Left`, otherwise `null`
  - `rightValue` - Returns the right value if this is a `Right`, otherwise `null`
- Core methods:
  - `fold<T>(T Function(L l) left, T Function(R r) right)` - Applies the appropriate function based on whether this is a `Left` or `Right`
  - `foldAsync<T>(FutureOr<T> Function(L l) left, FutureOr<T> Function(R r) right)` - Async version of `fold` that accepts both synchronous and asynchronous functions
  - `swap()` - Swaps the left and right types
- Transformation methods:
  - `map<T>(T Function(R r) f)` - Transforms the `Right` value using the given function
  - `mapLeft<T>(T Function(L l) f)` - Transforms the `Left` value using the given function
  - `bimap<L2, R2>(L2 Function(L l) left, R2 Function(R r) right)` - Transforms both `Left` and `Right` values using the given functions
- Composition methods:
  - `flatMap<T>(Either<L, T> Function(R r) f)` - Chains `Either` operations (monadic bind)
  - `getOrElse(R Function() orElse)` - Returns the right value if this is a `Right`, otherwise returns the result of calling `orElse` (lazy evaluation)
  - `orElse(Either<L, R> Function() alternative)` - Returns this `Either` if it's a `Right`, otherwise returns the result of calling `alternative` (lazy evaluation)
- Equatable support for value equality comparison
- Comprehensive test coverage
- README documentation with usage examples

### Dependencies

- `equatable: ^2.0.7` - For value equality
- `flutter` SDK - Required for Flutter support

### Requirements

- Dart SDK: ^3.10.1
- Flutter SDK

[0.0.1]: https://github.com/muhammadkamel/dartz_plus/releases/tag/v0.0.1

