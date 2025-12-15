# Changelog

All notable changes to this project will be documented in this file.

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

### Features

- **Automatic Mapper Generation**: Annotate DTOs with `@Mapper(TargetEntity)` to generate mapping extensions
- **Type Safety**: Compile-time validation ensures all required fields are mapped
- **Flexibility**: Control reverse mapping generation with `reverse` parameter
- **Smart Resolution**: Automatically handles optional and nullable fields

### Dependencies

- `analyzer: ^9.0.0`
- `build: ^4.0.3`
- `collection: ^1.19.1`
- `dartz_plus`: path dependency
- `source_gen: ^4.1.1`

### Dev Dependencies

- `build_runner: ^2.10.4`
- `lints: ^6.0.0`
- `source_gen_test: ^1.3.3`
- `test: ^1.26.3`

### Requirements

- Dart SDK: ^3.10.4

[0.1.0]: https://github.com/muhammadkamel/dartz_plus/releases/tag/dartz_plus_generator-v0.1.0
