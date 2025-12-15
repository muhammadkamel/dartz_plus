# Dartz Plus

A functional programming library for Dart and Flutter, providing powerful abstractions for handling errors and representing values that can be one of two types.

## Features

- **Either Type**: A disjoint union type that represents a value of one of two possible types
- **Type-Safe Error Handling**: Use `Left` for errors/failures and `Right` for success values
- **Functional Composition**: Chain operations and transform values safely with `map`, `flatMap`, and `bimap`
- **Equatable Support**: Built-in equality comparison using Equatable
- **Async Support**: Handle asynchronous operations with `foldAsync` (accepts both sync and async functions)
- **Future Extensions**: Chain operations on `Future<Either>` directly with `map`, `flatMap`, `fold`, and `getOrThrow`
- **Lazy Evaluation**: `getOrElse` and `orElse` use lazy evaluation for better performance

## Installation

Add `dartz_plus` to your `pubspec.yaml`:

```yaml
dependencies:
  dartz_plus: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:dartz_plus/dartz_plus.dart';

// Create a Left (error) value
final error = Either<String, int>.left('Something went wrong');

// Create a Right (success) value
final success = Either<String, int>.right(42);

// Check which side it is
if (success.isRight) {
  print('Success!');
}

// Get the value (returns null if on the other side)
final value = success.rightValue; // 42
final errorMsg = error.leftValue; // 'Something went wrong'
```

### Using `fold` to Transform Values

```dart
final either = Either<String, int>.right(10);

final result = either.fold(
  (error) => 'Error: $error',
  (value) => 'Value: ${value * 2}',
);

print(result); // 'Value: 20'
```

### Async Operations with `foldAsync`

```dart
final either = Either<String, int>.right(5);

final result = await either.foldAsync(
  (error) => 'Error: $error', // Can return Future or value directly
  (value) => Future.delayed(
    Duration(seconds: 1),
    () => 'Computed: ${value * 2}',
  ),
);

print(result); // 'Computed: 10'
```

### Swapping Left and Right

```dart
final either = Either<String, int>.left('error');
final swapped = either.swap(); // Now Either<int, String>.right('error')
```

### Transforming Values with `map` and `mapLeft`

```dart
// Transform Right values
final success = Either<String, int>.right(5);
final doubled = success.map((value) => value * 2);
print(doubled.rightValue); // 10

// Transform Left values
final error = Either<String, int>.left('error');
final upperError = error.mapLeft((msg) => msg.toUpperCase());
print(upperError.leftValue); // 'ERROR'

// Transform both sides at once with bimap
final result = Either<String, int>.right(5);
final transformed = result.bimap(
  (left) => left.toUpperCase(),
  (right) => right * 2,
);
print(transformed.rightValue); // 10
```

### Chaining Operations with `flatMap`

```dart
Either<String, int> divide(int a, int b) {
  if (b == 0) return Either.left('Division by zero');
  return Either.right(a ~/ b);
}

Either<String, int> multiply(int a, int b) {
  return Either.right(a * b);
}

void main() {
  // Chain operations - if any step fails, the error propagates
  final result = divide(10, 2)
      .flatMap((value) => multiply(value, 3))
      .flatMap((value) => divide(value, 2));

  result.fold(
    (error) => print('Error: $error'),
    (value) => print('Result: $value'), // Prints: Result: 7
  );
}
```

### Getting Values with `getOrElse` and `orElse`

```dart
// Get value or provide a default (lazy evaluation)
final either = Either<String, int>.left('error');
final value = either.getOrElse(() => 0); // 0

// Provide alternative Either if this is Left
final result = Either<String, int>.left('error');
final alternative = result.orElse(() => Either.right(42));
print(alternative.rightValue); // 42
```

### Error Handling Example

```dart
Either<String, int> divide(int a, int b) {
  if (b == 0) {
    return Either.left('Division by zero');
  }
  return Either.right(a ~/ b);
}

void main() {
  final result1 = divide(10, 2);
  final result2 = divide(10, 0);

  result1.fold(
    (error) => print('Error: $error'),
    (value) => print('Result: $value'), // Prints: Result: 5
  );

  result2.fold(
    (error) => print('Error: $error'), // Prints: Error: Division by zero
    (value) => print('Result: $value'),
  );
}
    (value) => print('Result: $value'),
  );
}
```

### Future Extensions

Easily work with `Future<Either<L, R>>`:

```dart
Future<Either<String, int>> fetchUserAge() async {
  // ...
  return Right(25);
}

void main() async {
  final result = await fetchUserAge()
      .map((age) => age + 1)
      .flatMap((age) => Future.value(Right('Age is $age')));

  result.fold(
    (l) => print('Error: $l'),
    (r) => print(r),
  );

  // Or get value/throw
  try {
    final age = await fetchUserAge().getOrThrow();
    print(age);
  } catch (e) {
    print('Failed: $e');
  }
}
```

## API Reference

### `Either<L, R>`

A sealed class representing a value that is either a `Left<L>` or a `Right<R>`.

#### Factory Constructors

- `Either.left(L value)`: Creates a `Left` instance
- `Either.right(R value)`: Creates a `Right` instance

#### Getters

- `bool isLeft`: Returns `true` if this is a `Left` instance
- `bool isRight`: Returns `true` if this is a `Right` instance
- `L? leftValue`: Returns the left value if this is a `Left`, otherwise `null`
- `R? rightValue`: Returns the right value if this is a `Right`, otherwise `null`

#### Methods

- `T fold<T>(T Function(L l) left, T Function(R r) right)`: Applies the appropriate function based on whether this is a `Left` or `Right`
- `Future<T> foldAsync<T>(FutureOr<T> Function(L l) left, FutureOr<T> Function(R r) right)`: Async version of `fold` that accepts both synchronous and asynchronous functions
- `Either<R, L> swap()`: Swaps the left and right types
- `Either<L, T> map<T>(T Function(R r) f)`: Transforms the `Right` value using the given function. If this is a `Left`, returns it unchanged
- `Either<T, R> mapLeft<T>(T Function(L l) f)`: Transforms the `Left` value using the given function. If this is a `Right`, returns it unchanged
- `Either<L2, R2> bimap<L2, R2>(L2 Function(L l) left, R2 Function(R r) right)`: Transforms both `Left` and `Right` values using the given functions
- `Either<L, T> flatMap<T>(Either<L, T> Function(R r) f)`: Chains `Either` operations (monadic bind). If this is a `Left`, returns it unchanged
- `R getOrElse(R Function() orElse)`: Returns the right value if this is a `Right`, otherwise returns the result of calling `orElse` (lazy evaluation)
- `Either<L, R> orElse(Either<L, R> Function() alternative)`: Returns this `Either` if it's a `Right`, otherwise returns the result of calling `alternative` (lazy evaluation)

### `Left<L, R>`

Represents the left side of an `Either`, typically used for errors or failure cases.

### `Right<L, R>`

Represents the right side of an `Either`, typically used for success values.

## Requirements

- Dart SDK: ^3.10.1

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under your chosen license.

## Links

- [Homepage](https://github.com/muhammadkamel/dartz_plus)
