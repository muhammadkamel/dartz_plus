# Dartz Plus Workspace

A comprehensive functional programming library for Dart and Flutter, providing powerful abstractions for type-safe error handling and functional composition.

## 📦 Packages

This is a Melos monorepo containing the following packages:

### [dartz_plus](./packages/dartz_plus)

[![pub package](https://img.shields.io/pub/v/dartz_plus.svg)](https://pub.dev/packages/dartz_plus)

The core functional programming library featuring:

- **Either Type**: Type-safe error handling with `Left` and `Right`
- **Functional Composition**: Chain operations with `map`, `flatMap`, and `bimap`
- **Async Support**: Handle asynchronous operations seamlessly
- **Future Extensions**: Work effortlessly with `Future<Either>`

[View Documentation →](./packages/dartz_plus/README.md)

### [dartz_plus_generator](./packages/dartz_plus_generator)

[![pub package](https://img.shields.io/pub/v/dartz_plus_generator.svg)](https://pub.dev/packages/dartz_plus_generator)

Code generation tools for dartz_plus:

- `@Either()` annotation for automatic Either type generation
- Build-time type-safe Either variant generation
- Reduces boilerplate for creating custom Either types

[View Documentation →](./packages/dartz_plus_generator/README.md)

## 🚀 Quick Start

### Installation

Add dartz_plus to your `pubspec.yaml`:

```yaml
dependencies:
  dartz_plus: ^0.2.0
```

For code generation, also add:

```yaml
dependencies:
  dartz_plus: ^0.2.0

dev_dependencies:
  dartz_plus_generator: ^0.1.1
  build_runner: ^2.4.0
```

### Basic Usage

```dart
import 'package:dartz_plus/dartz_plus.dart';

// Type-safe error handling
Either<String, int> divide(int a, int b) {
  if (b == 0) return Either.left('Division by zero');
  return Either.right(a ~/ b);
}

void main() {
  divide(10, 2).fold(
    (error) => print('Error: $error'),
    (value) => print('Result: $value'), // Prints: Result: 5
  );
}
```

## 🛠️ Development

This project uses [Melos](https://melos.invertase.dev/) to manage the monorepo.

### Setup

```bash
# Install Melos globally (if not already installed)
dart pub global activate melos

# Bootstrap the workspace
melos bootstrap
```

### Available Scripts

```bash
# Run all tests
melos run test

# Run Flutter tests
melos run test:flutter

# Run Dart tests
melos run test:dart

# Analyze all packages
melos run analyze

# Run build_runner in packages that need it
melos run build
```

### Project Structure

```
dartz_plus/
├── packages/
│   ├── dartz_plus/           # Core functional programming library
│   └── dartz_plus_generator/ # Code generation tools
├── example/                  # Example applications
├── melos.yaml               # Melos configuration
└── README.md                # This file
```

## 📚 Documentation

- [dartz_plus Documentation](./packages/dartz_plus/README.md)
- [dartz_plus_generator Documentation](./packages/dartz_plus_generator/README.md)
- [Example Projects](./example)

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests (`melos run test`)
5. Run analysis (`melos run analyze`)
6. Commit your changes (`git commit -m 'Add amazing feature'`)
7. Push to the branch (`git push origin feature/amazing-feature`)
8. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## 🔗 Links

- **Repository**: [https://github.com/muhammadkamel/dartz_plus](https://github.com/muhammadkamel/dartz_plus)
- **Issues**: [https://github.com/muhammadkamel/dartz_plus/issues](https://github.com/muhammadkamel/dartz_plus/issues)
- **pub.dev**:
  - [dartz_plus](https://pub.dev/packages/dartz_plus)
  - [dartz_plus_generator](https://pub.dev/packages/dartz_plus_generator)

## 🌟 Features Highlight

### Type-Safe Error Handling

```dart
Either<Exception, User> fetchUser(String id) async {
  try {
    final user = await api.getUser(id);
    return Either.right(user);
  } catch (e) {
    return Either.left(Exception('Failed to fetch user: $e'));
  }
}
```

### Functional Composition

```dart
final result = fetchUser('123')
  .map((user) => user.name)
  .flatMap((name) => validateName(name))
  .getOrElse(() => 'Unknown');
```

### Async Operations

```dart
final result = await either.foldAsync(
  (error) => handleError(error),
  (value) => processData(value),
);
```

---

Made with ❤️ by [Muhammad Kamel](https://github.com/muhammadkamel)
