# Changelog

All notable changes to this project will be documented in this file.

## [0.1.1] - 2025-01-03

### Changed

- **Breaking**: Moved `Mapper` annotation from `dartz_plus` package into `dartz_plus_generator`
- Updated all imports to use `package:dartz_plus_generator/annotations.dart`
- Removed `dartz_plus` dependency - generator is now fully independent
- Users should now import `@Mapper` annotation from `dartz_plus_generator` instead of `dartz_plus`

### Migration Guide

If upgrading from 0.1.0, update your imports:

```dart
// Before
import 'package:dartz_plus/dartz_plus.dart';

// After
import 'package:dartz_plus_generator/annotations.dart';
```

## [0.1.0] - 2025-12-15

### Added

- Initial release of `dartz_plus_generator`
- `@Mapper` annotation for automatic mapping code generation
- `MapperGenerator` class that generates bidirectional mapping extensions
- Support for generating `to{TargetName}()` extension methods
- Bidirectional mapping support (can be disabled with `reverse: false`)
- Smart field resolution that handles:
  - Optional parameters
  - Nullable parameters
  - Required parameter validation
- Inheritance support - collects fields from superclasses
- Comprehensive error messages for:
  - Invalid annotation targets
  - Missing constructors
  - Missing required fields
- `build.yaml` configuration for automatic code generation
- Full integration with `build_runner`

### Dev Dependencies

- `build_runner: ^2.10.4`
- `lints: ^6.0.0`
- `source_gen_test: ^1.3.3`
- `test: ^1.26.3`

### Requirements

- Dart SDK: ^3.10.4

[0.1.0]: https://github.com/muhammadkamel/dartz_plus/releases/tag/dartz_plus_generator-v0.1.0
