# CHANGELOG

## 0.3.0

- **New Features**:
  - Added support for custom field mapping using `@MapTo`.
  - Added support for ignoring fields using `@IgnoreMap`.
  - Added support for specifying a target class constructor in the `@Mapper` annotation.
  - Enhanced field resolution to support bidirectional mapping with a single `@MapTo` annotation.

## 0.2.0

- **Breaking Changes**:
  - Added support for automatic nested object and list mapping (Recursive Mapping). This may change generated code for types that were previously ignored.

- **New Features**:
  - **Recursive Mapping**: Added support for automatic nested object and list mapping.
    - Generates `.toTarget()` for single object type mismatches.
    - Generates `.map((e) => e.toTarget()).toList()` for `List` type mismatches.
  - **Freezed Support**: Enhanced property lookup to work with Freezed factory constructors by falling back to constructor parameters if fields are not present.
  - **Auto-Apply Builder**: Enabled `auto_apply: dependents` in `build.yaml`, so users no longer need to manually enable the builder in their `build.yaml`.
  - **Smart Resolution**: Improved field matching to handle optional and nullable parameters gracefully.

- **Fixes**:
  - Improved robustness of field resolution for inherited properties.
  - Aligned generated code formatting with `dart format`.

## 0.1.1

- Added `dartz_plus` dependency to share `Mapper` annotation.
- Switched to `SharedPartBuilder` for better compatibility with other generators.

## 0.1.0

- Initial release of `dartz_plus_generator`.
- Support for basic `@Mapper` annotation and extension-based mapping.
