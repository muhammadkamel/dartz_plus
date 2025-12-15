import 'package:dartz_plus_generator/annotations.dart';

part 'models.g.dart';

// Example 1: Simple bidirectional mapping
@Mapper(UserEntity)
class UserDto {
  final String name;
  final int age;

  UserDto({required this.name, required this.age});

  @override
  String toString() => 'UserDto(name: $name, age: $age)';
}

class UserEntity {
  final String name;
  final int age;

  const UserEntity({required this.name, required this.age});

  @override
  String toString() => 'UserEntity(name: $name, age: $age)';
}

// Example 2: Mapping with optional fields
@Mapper(ProductEntity)
class ProductDto {
  final String id;
  final String name;
  final double price;

  ProductDto({required this.id, required this.name, required this.price});

  @override
  String toString() => 'ProductDto(id: $id, name: $name, price: $price)';
}

class ProductEntity {
  final String id;
  final String name;
  final double price;
  final String? category; // Optional field - will be null when mapped from DTO

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.category,
  });

  @override
  String toString() =>
      'ProductEntity(id: $id, name: $name, price: $price, category: $category)';
}

// Example 3: One-way mapping (no reverse)
@Mapper(OrderEntity, reverse: false)
class OrderDto {
  final String orderId;
  final String customerName;

  OrderDto({required this.orderId, required this.customerName});

  @override
  String toString() =>
      'OrderDto(orderId: $orderId, customerName: $customerName)';
}

class OrderEntity {
  final String orderId;
  final String customerName;

  const OrderEntity({required this.orderId, required this.customerName});

  @override
  String toString() =>
      'OrderEntity(orderId: $orderId, customerName: $customerName)';
}
