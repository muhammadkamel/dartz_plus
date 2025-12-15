// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'models.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

extension UserDtoToUserEntityMapper on UserDto {
  UserEntity toUserEntity() {
    return UserEntity(name: name, age: age);
  }
}

extension UserEntityToUserDtoMapper on UserEntity {
  UserDto toUserDto() {
    return UserDto(name: name, age: age);
  }
}

extension ProductDtoToProductEntityMapper on ProductDto {
  ProductEntity toProductEntity() {
    return ProductEntity(id: id, name: name, price: price);
  }
}

extension ProductEntityToProductDtoMapper on ProductEntity {
  ProductDto toProductDto() {
    return ProductDto(id: id, name: name, price: price);
  }
}

extension OrderDtoToOrderEntityMapper on OrderDto {
  OrderEntity toOrderEntity() {
    return OrderEntity(orderId: orderId, customerName: customerName);
  }
}
