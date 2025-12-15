import 'models.dart';

void main() {
  print('=== Dartz Plus Generator Example ===\n');

  // Example 1: Bidirectional mapping
  print('Example 1: Bidirectional Mapping');
  final userDto = UserDto(name: 'Alice', age: 30);
  print('Original DTO: $userDto');

  final userEntity = userDto.toUserEntity();
  print('Mapped to Entity: $userEntity');

  final backToDto = userEntity.toUserDto();
  print('Mapped back to DTO: $backToDto\n');

  // Example 2: Mapping with optional fields
  print('Example 2: Mapping with Optional Fields');
  final productDto = ProductDto(id: 'P001', name: 'Laptop', price: 999.99);
  print('Original DTO: $productDto');

  final productEntity = productDto.toProductEntity();
  print('Mapped to Entity: $productEntity');
  print('Note: category is null because it was not in the DTO\n');

  // Example 3: One-way mapping
  print('Example 3: One-way Mapping (no reverse)');
  final orderDto = OrderDto(orderId: 'ORD-123', customerName: 'Bob Smith');
  print('Original DTO: $orderDto');

  final orderEntity = orderDto.toOrderEntity();
  print('Mapped to Entity: $orderEntity');
  print(
    'Note: No reverse mapping (toOrderDto) is generated for this example\n',
  );

  print(
    '=== Run "dart run build_runner build -d" to generate the mapping code ===',
  );
}
