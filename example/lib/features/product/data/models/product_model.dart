import 'package:dartz_plus/dartz_plus.dart';

import '../../domain/entities/product_entity.dart';

part 'product_model.g.dart';

@Mapper(ProductEntity)
class ProductModel {
  final int id;

  @MapTo('title')
  final String productName;

  final double price;

  @MapTo('category')
  final String? type;

  @IgnoreMap()
  final String? internalRef;

  ProductModel({
    required this.id,
    required this.productName,
    required this.price,
    this.type,
    this.internalRef,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      productName: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      type: json['category'] as String,
      internalRef: 'REF-${json['id']}',
    );
  }

  @override
  String toString() =>
      'ProductModel(id: $id, name: $productName, type: $type, ref: $internalRef)';
}
