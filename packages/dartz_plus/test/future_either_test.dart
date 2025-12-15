import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FutureEitherExtensions', () {
    test('map transforms Right value', () async {
      final Future<Either<String, int>> futureEither = Future.value(
        const Right(10),
      );
      final Either<String, int> result = await futureEither.map((r) => r * 2);

      expect(result.isRight, isTrue);
      expect(result.rightValue, equals(20));
    });

    test('map respects Left value', () async {
      final Future<Either<String, int>> futureEither = Future.value(
        const Left('error'),
      );
      final Either<String, int> result = await futureEither.map((r) => r * 2);

      expect(result.isLeft, isTrue);
      expect(result.leftValue, equals('error'));
    });

    test('mapLeft transforms Left value', () async {
      final Future<Either<String, int>> futureEither = Future.value(
        const Left('error'),
      );
      final Either<String, int> result = await futureEither.mapLeft(
        (l) => 'mapped $l',
      );

      expect(result.isLeft, isTrue);
      expect(result.leftValue, equals('mapped error'));
    });

    test('mapLeft respects Right value', () async {
      final Future<Either<String, int>> futureEither = Future.value(
        const Right(10),
      );
      final Either<String, int> result = await futureEither.mapLeft(
        (l) => 'mapped $l',
      );

      expect(result.isRight, isTrue);
      expect(result.rightValue, equals(10));
    });

    test('flatMap chains async operations', () async {
      final Future<Either<String, int>> futureEither = Future.value(
        const Right(10),
      );
      final Either<String, int> result = await futureEither.flatMap(
        (r) => Future.value(Right(r * 2)),
      );

      expect(result.isRight, isTrue);
      expect(result.rightValue, equals(20));
    });

    test('flatMap respects Left value', () async {
      final Future<Either<String, int>> futureEither = Future.value(
        const Left('error'),
      );
      final Either<String, int> result = await futureEither.flatMap(
        (r) => Future.value(Right(r * 2)),
      );

      expect(result.isLeft, isTrue);
      expect(result.leftValue, equals('error'));
    });

    test('flatMap can return Left', () async {
      final Future<Either<String, int>> futureEither = Future.value(
        const Right(10),
      );
      final Either<String, dynamic> result = await futureEither.flatMap(
        (r) => Future.value(const Left('new error')),
      );

      expect(result.isLeft, isTrue);
      expect(result.leftValue, equals('new error'));
    });

    test('fold handles both cases', () async {
      final Future<Either<String, int>> right = Future.value(const Right(10));
      final Future<Either<String, int>> left = Future.value(
        const Left('error'),
      );

      final String rightResult = await right.fold(
        (l) => 'Left: $l',
        (r) => 'Right: $r',
      );
      final String leftResult = await left.fold(
        (l) => 'Left: $l',
        (r) => 'Right: $r',
      );

      expect(rightResult, equals('Right: 10'));
      expect(leftResult, equals('Left: error'));
    });

    test('getOrThrow returns value for Right', () async {
      final Future<Either<String, int>> futureEither = Future.value(
        const Right(10),
      );
      final int result = await futureEither.getOrThrow();
      expect(result, equals(10));
    });

    test('getOrThrow throws for Left', () async {
      final Future<Either<String, int>> futureEither = Future.value(
        const Left('error'),
      );
      expect(() => futureEither.getOrThrow(), throwsException);
    });

    test('getOrThrow throws transformed exception', () async {
      final Future<Either<String, int>> futureEither = Future.value(
        const Left('error'),
      );
      expect(
        () => futureEither.getOrThrow((l) => Exception(l)),
        throwsException,
      );
    });
  });
}
