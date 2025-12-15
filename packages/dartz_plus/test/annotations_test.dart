import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Mapper annotation instantiates correctly', () {
    const annotation = Mapper(String);
    expect(annotation, isA<Mapper>());
  });
}
