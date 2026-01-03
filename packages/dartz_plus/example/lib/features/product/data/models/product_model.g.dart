// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

extension ProductModelToProductEntityMapper on ProductModel {
  ProductEntity toProductEntity() {
    return ProductEntity(
      id: id,
      title: productName,
      price: price,
      category: type,
    );
  }
}

extension ProductEntityToProductModelMapper on ProductEntity {
  ProductModel toProductModel() {
    return ProductModel(
      id: id,
      productName: title,
      price: price,
      type: category,
    );
  }
}
