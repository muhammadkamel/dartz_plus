import 'models.dart';

void main() {
  print('=== Dartz Plus Generator Example ===\n');

  // Example 1: Bidirectional mapping
  print('Example 1: Bidirectional Mapping');
  final userModel = UserModel(name: 'Alice', age: 30);
  print('Original Model: $userModel');

  final userEntity = userModel.toUserEntity();
  print('Mapped to Entity: $userEntity');

  final backToModel = userEntity.toUserModel();
  print('Mapped back to Model: $backToModel\n');

  // Example 2: Mapping with optional fields
  print('Example 2: Mapping with Optional Fields');
  final productModel = ProductModel(id: 'P001', name: 'Laptop', price: 999.99);
  print('Original Model: $productModel');

  final productEntity = productModel.toProductEntity();
  print('Mapped to Entity: $productEntity');
  print('Note: category is null because it was not in the Model\n');

  // Example 3: One-way mapping
  print('Example 3: One-way Mapping (no reverse)');
  final orderModel = OrderModel(orderId: 'ORD-123', customerName: 'Bob Smith');
  print('Original Model: $orderModel');

  final orderEntity = orderModel.toOrderEntity();
  print('Mapped to Entity: $orderEntity');
  print(
    'Note: No reverse mapping (toOrderModel) is generated for this example\n',
  );

  print(
    '=== Run "dart run build_runner build -d" to generate the mapping code ===',
  );
}
