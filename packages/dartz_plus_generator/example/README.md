# Dartz Plus Generator Example

This example demonstrates how to use `dartz_plus_generator` to automatically generate mapping extensions between DTOs and entities.

## Setup

1. Install dependencies:

```bash
dart pub get
```

2. Run the code generator:

```bash
dart run build_runner build
```

This will generate `lib/models.g.dart` with the mapper extensions.

## Examples Included

### Example 1: Bidirectional Mapping

```dart
@Mapper(UserEntity)
class UserModel {
  final String name;
  final int age;
  // ...
}
```

Generates both `userModel.toUserEntity()` and `userEntity.toUserModel()` methods.

### Example 2: Mapping with Optional Fields

```dart
@Mapper(ProductEntity)
class ProductModel {
  final String id;
  final String name;
  final double price;
  // ProductEntity has an optional 'category' field
}
```

The generator handles optional fields intelligently - they will be null if not present in the source.

### Example 3: One-Way Mapping

```dart
@Mapper(OrderEntity, reverse: false)
class OrderModel {
  // ...
}
```

Only generates `orderModel.toOrderEntity()` - no reverse mapping.

## Running the Example

After generating the code, run:

```bash
dart run lib/main.dart
```

## Watch Mode

For continuous code generation during development:

```bash
dart run build_runner watch
```
