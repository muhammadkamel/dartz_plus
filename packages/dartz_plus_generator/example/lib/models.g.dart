// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

extension UserModelToUserEntityMapper on UserModel {
  UserEntity toUserEntity() {
    return UserEntity(name: name, age: age);
  }
}

extension UserEntityToUserModelMapper on UserEntity {
  UserModel toUserModel() {
    return UserModel(name: name, age: age);
  }
}

extension ProductModelToProductEntityMapper on ProductModel {
  ProductEntity toProductEntity() {
    return ProductEntity(id: id, name: name, price: price);
  }
}

extension ProductEntityToProductModelMapper on ProductEntity {
  ProductModel toProductModel() {
    return ProductModel(id: id, name: name, price: price);
  }
}

extension OrderModelToOrderEntityMapper on OrderModel {
  OrderEntity toOrderEntity() {
    return OrderEntity(orderId: orderId, customerName: customerName);
  }
}

extension AdvancedModelToAdvancedEntityMapper on AdvancedModel {
  AdvancedEntity toAdvancedEntity() {
    return AdvancedEntity.fromDto(fullName: name, status: status);
  }
}

extension AdvancedEntityToAdvancedModelMapper on AdvancedEntity {
  AdvancedModel toAdvancedModel() {
    return AdvancedModel(name: fullName, status: status);
  }
}
