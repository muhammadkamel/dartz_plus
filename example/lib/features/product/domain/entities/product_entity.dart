class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String? category;
  final String? description;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    this.category,
    this.description,
  });

  @override
  String toString() =>
      'ProductEntity(id: $id, title: $title, price: $price, category: $category)';
}
