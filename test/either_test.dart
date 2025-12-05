import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Either', () {
    group('factory constructors', () {
      test('Either.left creates a Left instance', () {
        const either = Either<String, int>.left('error');
        expect(either, isA<Left<String, int>>());
        expect(either.isLeft, isTrue);
        expect(either.isRight, isFalse);
      });

      test('Either.right creates a Right instance', () {
        const either = Either<String, int>.right(42);
        expect(either, isA<Right<String, int>>());
        expect(either.isLeft, isFalse);
        expect(either.isRight, isTrue);
      });
    });

    group('isLeft', () {
      test('returns true for Left instance', () {
        const either = Either<String, int>.left('error');
        expect(either.isLeft, isTrue);
      });

      test('returns false for Right instance', () {
        const either = Either<String, int>.right(42);
        expect(either.isLeft, isFalse);
      });
    });

    group('isRight', () {
      test('returns true for Right instance', () {
        const either = Either<String, int>.right(42);
        expect(either.isRight, isTrue);
      });

      test('returns false for Left instance', () {
        const either = Either<String, int>.left('error');
        expect(either.isRight, isFalse);
      });
    });

    group('fold', () {
      test('applies left function for Left instance', () {
        const either = Either<String, int>.left('error');
        final String result = either.fold(
          (l) => 'Left: $l',
          (r) => 'Right: $r',
        );
        expect(result, equals('Left: error'));
      });

      test('applies right function for Right instance', () {
        const either = Either<String, int>.right(42);
        final String result = either.fold(
          (l) => 'Left: $l',
          (r) => 'Right: $r',
        );
        expect(result, equals('Right: 42'));
      });

      test('can return different types', () {
        const leftEither = Either<String, int>.left('error');
        const rightEither = Either<String, int>.right(42);

        final int leftResult = leftEither.fold((l) => 0, (r) => r);
        final int rightResult = rightEither.fold((l) => 0, (r) => r);

        expect(leftResult, equals(0));
        expect(rightResult, equals(42));
      });
    });

    group('foldAsync', () {
      test('applies left async function for Left instance', () async {
        const either = Either<String, int>.left('error');
        final String result = await either.foldAsync(
          (l) => Future.value('Left: $l'),
          (r) => Future.value('Right: $r'),
        );
        expect(result, equals('Left: error'));
      });

      test('applies right async function for Right instance', () async {
        const either = Either<String, int>.right(42);
        final String result = await either.foldAsync(
          (l) => Future.value('Left: $l'),
          (r) => Future.value('Right: $r'),
        );
        expect(result, equals('Right: 42'));
      });

      test('handles async operations correctly', () async {
        const either = Either<String, int>.right(10);
        final int result = await either.foldAsync(
          (l) => Future.delayed(const Duration(milliseconds: 10), () => 0),
          (r) => Future.delayed(const Duration(milliseconds: 10), () => r * 2),
        );
        expect(result, equals(20));
      });

      test('handles synchronous functions for Left instance', () async {
        const either = Either<String, int>.left('error');
        final String result = await either.foldAsync(
          (l) => 'Left: $l', // Synchronous function
          (r) => 'Right: $r',
        );
        expect(result, equals('Left: error'));
      });

      test('handles synchronous functions for Right instance', () async {
        const either = Either<String, int>.right(42);
        final String result = await either.foldAsync(
          (l) => 'Left: $l',
          (r) => 'Right: $r', // Synchronous function
        );
        expect(result, equals('Right: 42'));
      });
    });

    group('swap', () {
      test('swaps Left to Right', () {
        const either = Either<String, int>.left('error');
        final Either<int, String> swapped = either.swap();
        expect(swapped, isA<Right<int, String>>());
        expect(swapped.isRight, isTrue);
        expect(swapped.rightValue, equals('error'));
      });

      test('swaps Right to Left', () {
        const either = Either<String, int>.right(42);
        final Either<int, String> swapped = either.swap();
        expect(swapped, isA<Left<int, String>>());
        expect(swapped.isLeft, isTrue);
        expect(swapped.leftValue, equals(42));
      });

      test('double swap returns to original', () {
        const original = Either<String, int>.left('error');
        final Either<int, String> swapped = original.swap();
        final Either<String, int> doubleSwapped = swapped.swap();
        expect(doubleSwapped.isLeft, isTrue);
        expect(doubleSwapped.leftValue, equals('error'));
      });
    });

    group('leftValue', () {
      test('returns value for Left instance', () {
        const either = Either<String, int>.left('error');
        expect(either.leftValue, equals('error'));
      });

      test('returns null for Right instance', () {
        const either = Either<String, int>.right(42);
        expect(either.leftValue, isNull);
      });
    });

    group('rightValue', () {
      test('returns value for Right instance', () {
        const either = Either<String, int>.right(42);
        expect(either.rightValue, equals(42));
      });

      test('returns null for Left instance', () {
        const either = Either<String, int>.left('error');
        expect(either.rightValue, isNull);
      });
    });

    group('Left', () {
      test('stores the value correctly', () {
        const left = Left<String, int>('error');
        expect(left.value, equals('error'));
      });

      test('is equal to another Left with same value', () {
        const left1 = Left<String, int>('error');
        const left2 = Left<String, int>('error');
        expect(left1, equals(left2));
      });

      test('is not equal to Left with different value', () {
        const left1 = Left<String, int>('error');
        const left2 = Left<String, int>('different');
        expect(left1, isNot(equals(left2)));
      });

      test('is not equal to Right with same value', () {
        const left = Left<String, int>('error');
        const right = Right<String, String>('error');
        expect(left, isNot(equals(right)));
      });

      test('toString returns formatted string', () {
        const left = Left<String, int>('error');
        expect(left.toString(), equals('Left(error)'));
      });

      test('toString handles null values', () {
        const left = Left<String?, int>(null);
        expect(left.toString(), equals('Left(null)'));
      });

      test('toString handles complex values', () {
        const left = Left<List<String>, int>(['error1', 'error2']);
        expect(left.toString(), contains('Left'));
        expect(left.toString(), contains('error1'));
      });
    });

    group('Right', () {
      test('stores the value correctly', () {
        const right = Right<String, int>(42);
        expect(right.value, equals(42));
      });

      test('is equal to another Right with same value', () {
        const right1 = Right<String, int>(42);
        const right2 = Right<String, int>(42);
        expect(right1, equals(right2));
      });

      test('is not equal to Right with different value', () {
        const right1 = Right<String, int>(42);
        const right2 = Right<String, int>(100);
        expect(right1, isNot(equals(right2)));
      });

      test('is not equal to Left with same value', () {
        const left = Left<int, String>(42);
        const right = Right<String, int>(42);
        expect(left, isNot(equals(right)));
      });

      test('toString returns formatted string', () {
        const right = Right<String, int>(42);
        expect(right.toString(), equals('Right(42)'));
      });

      test('toString handles null values', () {
        const right = Right<String, int?>(null);
        expect(right.toString(), equals('Right(null)'));
      });

      test('toString handles complex values', () {
        const right = Right<String, List<int>>([1, 2, 3]);
        expect(right.toString(), contains('Right'));
        expect(right.toString(), contains('[1, 2, 3]'));
      });
    });

    group('Equatable', () {
      group('equality operator (==)', () {
        test('Left instances with same value are equal using ==', () {
          const left1 = Left<String, int>('error');
          const left2 = Left<String, int>('error');
          expect(left1 == left2, isTrue);
        });

        test('Right instances with same value are equal using ==', () {
          const right1 = Right<String, int>(42);
          const right2 = Right<String, int>(42);
          expect(right1 == right2, isTrue);
        });

        test('Left instances with different values are not equal', () {
          const left1 = Left<String, int>('error');
          const left2 = Left<String, int>('different');
          expect(left1 == left2, isFalse);
        });

        test('Right instances with different values are not equal', () {
          const right1 = Right<String, int>(42);
          const right2 = Right<String, int>(100);
          expect(right1 == right2, isFalse);
        });

        test('Left and Right are never equal even with same value', () {
          const left = Left<String, int>('error');
          const right = Right<String, String>('error');
          // ignore: unrelated_type_equality_checks
          expect(left == right, isFalse);
        });

        test(
          'Left instances with same value but different right type are not equal',
          () {
            const left1 = Left<String, int>('error');
            const left2 = Left<String, String>('error');
            // These are different types, so they can't be compared with ==
            // But we can verify they are different instances
            expect(left1.value == left2.value, isTrue);
            expect(left1.runtimeType != left2.runtimeType, isTrue);
          },
        );

        test(
          'Right instances with same value but different left type are not equal',
          () {
            const right1 = Right<String, int>(42);
            const right2 = Right<int, int>(42);
            // These are different types, so they can't be compared with ==
            // But we can verify they are different instances
            expect(right1.value == right2.value, isTrue);
            expect(right1.runtimeType != right2.runtimeType, isTrue);
          },
        );

        test('instance equals itself (identity)', () {
          const left = Left<String, int>('error');
          expect(left == left, isTrue);
        });

        test('Left with null values are equal', () {
          const left1 = Left<String?, int>(null);
          const left2 = Left<String?, int>(null);
          expect(left1 == left2, isTrue);
        });

        test('Right with null values are equal', () {
          const right1 = Right<String, int?>(null);
          const right2 = Right<String, int?>(null);
          expect(right1 == right2, isTrue);
        });
      });

      group('hashCode', () {
        test('Left instances with same value have same hashCode', () {
          const left1 = Left<String, int>('error');
          const left2 = Left<String, int>('error');
          expect(left1.hashCode, equals(left2.hashCode));
        });

        test('Right instances with same value have same hashCode', () {
          const right1 = Right<String, int>(42);
          const right2 = Right<String, int>(42);
          expect(right1.hashCode, equals(right2.hashCode));
        });

        test(
          'Left instances with different values have different hashCode',
          () {
            const left1 = Left<String, int>('error');
            const left2 = Left<String, int>('different');
            expect(left1.hashCode, isNot(equals(left2.hashCode)));
          },
        );

        test(
          'Right instances with different values have different hashCode',
          () {
            const right1 = Right<String, int>(42);
            const right2 = Right<String, int>(100);
            expect(right1.hashCode, isNot(equals(right2.hashCode)));
          },
        );

        test('Left and Right with same value have different hashCode', () {
          const left = Left<int, String>(42);
          const right = Right<String, int>(42);
          expect(left.hashCode, isNot(equals(right.hashCode)));
        });

        test('Left with null values have same hashCode', () {
          const left1 = Left<String?, int>(null);
          const left2 = Left<String?, int>(null);
          expect(left1.hashCode, equals(left2.hashCode));
        });

        test('Right with null values have same hashCode', () {
          const right1 = Right<String, int?>(null);
          const right2 = Right<String, int?>(null);
          expect(right1.hashCode, equals(right2.hashCode));
        });
      });

      group('props', () {
        test('Left props contains the value', () {
          const left = Left<String, int>('error');
          expect(left.props, equals(['error']));
        });

        test('Right props contains the value', () {
          const right = Right<String, int>(42);
          expect(right.props, equals([42]));
        });

        test('Left props with null contains null', () {
          const left = Left<String?, int>(null);
          expect(left.props, equals([null]));
        });

        test('Right props with null contains null', () {
          const right = Right<String, int?>(null);
          expect(right.props, equals([null]));
        });
      });
    });

    group('edge cases', () {
      test('handles null values in Left', () {
        const either = Either<String?, int>.left(null);
        expect(either.isLeft, isTrue);
        expect(either.leftValue, isNull);
        expect(either.rightValue, isNull);
      });

      test('handles null values in Right', () {
        const either = Either<String, int?>.right(null);
        expect(either.isRight, isTrue);
        expect(either.leftValue, isNull);
        expect(either.rightValue, isNull);
      });

      test('handles complex types', () {
        const either = Either<String, List<int>>.right([1, 2, 3]);
        expect(either.isRight, isTrue);
        expect(either.rightValue, equals([1, 2, 3]));
      });

      test('fold can throw exceptions', () {
        const either = Either<String, int>.left('error');
        expect(
          () => either.fold((l) => throw Exception('Left error'), (r) => r),
          throwsException,
        );
      });

      test('foldAsync can throw exceptions', () async {
        const either = Either<String, int>.left('error');
        expect(
          () => either.foldAsync(
            (l) => throw Exception('Left error'),
            (r) => Future.value(r),
          ),
          throwsException,
        );
      });

      test('fromNullable with different types', () {
        final Either<String, int> either1 = Either.fromNullable<String, int>(
          42,
          () => 'null',
        );
        final Either<String, String> either2 =
            Either.fromNullable<String, String>('test', () => 'null');
        final Either<String, bool> either3 = Either.fromNullable<String, bool>(
          true,
          () => 'null',
        );

        expect(either1.isRight, isTrue);
        expect(either1.rightValue, equals(42));
        expect(either2.isRight, isTrue);
        expect(either2.rightValue, equals('test'));
        expect(either3.isRight, isTrue);
        expect(either3.rightValue, equals(true));
      });

      test('cond with different types', () {
        final Either<String, int> either1 = Either.cond<String, int>(
          true,
          () => 42,
          () => 'error',
        );
        final Either<String, String> either2 = Either.cond<String, String>(
          false,
          () => 'success',
          () => 'error',
        );

        expect(either1.isRight, isTrue);
        expect(either1.rightValue, equals(42));
        expect(either2.isLeft, isTrue);
        expect(either2.leftValue, equals('error'));
      });
    });

    group('map', () {
      test('transforms Right value', () {
        const either = Either<String, int>.right(5);
        final Either<String, int> result = either.map((r) => r * 2);
        expect(result.isRight, isTrue);
        expect(result.rightValue, equals(10));
      });

      test('leaves Left unchanged', () {
        const either = Either<String, int>.left('error');
        final Either<String, int> result = either.map((r) => r * 2);
        expect(result.isLeft, isTrue);
        expect(result.leftValue, equals('error'));
      });

      test('can change the type', () {
        const either = Either<String, int>.right(5);
        final Either<String, String> result = either.map((r) => r.toString());
        expect(result.isRight, isTrue);
        expect(result.rightValue, equals('5'));
      });
    });

    group('mapLeft', () {
      test('transforms Left value', () {
        const either = Either<String, int>.left('error');
        final Either<String, int> result = either.mapLeft(
          (l) => l.toUpperCase(),
        );
        expect(result.isLeft, isTrue);
        expect(result.leftValue, equals('ERROR'));
      });

      test('leaves Right unchanged', () {
        const either = Either<String, int>.right(42);
        final Either<String, int> result = either.mapLeft(
          (l) => l.toUpperCase(),
        );
        expect(result.isRight, isTrue);
        expect(result.rightValue, equals(42));
      });

      test('can change the type', () {
        const either = Either<int, String>.left(5);
        final Either<String, String> result = either.mapLeft(
          (l) => l.toString(),
        );
        expect(result.isLeft, isTrue);
        expect(result.leftValue, equals('5'));
      });
    });

    group('bimap', () {
      test('transforms Left value', () {
        const either = Either<String, int>.left('error');
        final Either<String, int> result = either.bimap(
          (l) => l.toUpperCase(),
          (r) => r * 2,
        );
        expect(result.isLeft, isTrue);
        expect(result.leftValue, equals('ERROR'));
      });

      test('transforms Right value', () {
        const either = Either<String, int>.right(5);
        final Either<String, int> result = either.bimap(
          (l) => l.toUpperCase(),
          (r) => r * 2,
        );
        expect(result.isRight, isTrue);
        expect(result.rightValue, equals(10));
      });

      test('can change both types', () {
        const either = Either<int, int>.left(1);
        final Either<String, String> result = either.bimap(
          (l) => 'L$l',
          (r) => 'R$r',
        );
        expect(result.isLeft, isTrue);
        expect(result.leftValue, equals('L1'));
      });
    });

    group('flatMap', () {
      test('chains Right operations', () {
        const either = Either<String, int>.right(5);
        final Either<String, int> result = either.flatMap(
          (r) => Either.right(r * 2),
        );
        expect(result.isRight, isTrue);
        expect(result.rightValue, equals(10));
      });

      test('chains Left from flatMap', () {
        const either = Either<String, int>.right(5);
        final Either<String, int> result = either.flatMap(
          (r) => const Either.left('failed'),
        );
        expect(result.isLeft, isTrue);
        expect(result.leftValue, equals('failed'));
      });

      test('leaves Left unchanged', () {
        const either = Either<String, int>.left('error');
        final Either<String, int> result = either.flatMap(
          (r) => Either.right(r * 2),
        );
        expect(result.isLeft, isTrue);
        expect(result.leftValue, equals('error'));
      });

      test('can change the type', () {
        const either = Either<String, int>.right(5);
        final Either<String, String> result = either.flatMap(
          (r) => Either.right(r.toString()),
        );
        expect(result.isRight, isTrue);
        expect(result.rightValue, equals('5'));
      });
    });

    group('getOrElse', () {
      test('returns Right value', () {
        const either = Either<String, int>.right(42);
        expect(either.getOrElse(() => 0), equals(42));
      });

      test('returns default for Left', () {
        const either = Either<String, int>.left('error');
        expect(either.getOrElse(() => 0), equals(0));
      });

      test('works with different default types', () {
        const either = Either<String, int>.left('error');
        expect(either.getOrElse(() => 100), equals(100));
      });
    });

    group('orElse', () {
      test('returns Right when it is Right', () {
        const either = Either<String, int>.right(42);
        const Either<String, int> alternative = Either.right(0);
        final Either<String, int> result = either.orElse(() => alternative);
        expect(result.isRight, isTrue);
        expect(result.rightValue, equals(42));
      });

      test('returns alternative when it is Left', () {
        const either = Either<String, int>.left('error');
        const Either<String, int> alternative = Either.right(0);
        final Either<String, int> result = either.orElse(() => alternative);
        expect(result.isRight, isTrue);
        expect(result.rightValue, equals(0));
      });

      test('returns Left alternative when original is Left', () {
        const either = Either<String, int>.left('error1');
        const Either<String, int> alternative = Either.left('error2');
        final Either<String, int> result = either.orElse(() => alternative);
        expect(result.isLeft, isTrue);
        expect(result.leftValue, equals('error2'));
      });
    });

    group('fromNullable', () {
      test('returns Right when value is not null', () {
        final Either<String, int> either = Either.fromNullable<String, int>(
          42,
          () => 'null',
        );
        expect(either.isRight, isTrue);
        expect(either.rightValue, equals(42));
      });

      test('returns Left when value is null', () {
        final Either<String, int> either = Either.fromNullable<String, int>(
          null,
          () => 'null',
        );
        expect(either.isLeft, isTrue);
        expect(either.leftValue, equals('null'));
      });
    });

    group('tryCatch', () {
      test('returns Right when function returns successfully', () {
        final Either<String, int> either = Either.tryCatch<String, int>(
          () => int.parse('42'),
          (e, s) => 'error',
        );
        expect(either.isRight, isTrue);
        expect(either.rightValue, equals(42));
      });

      test('returns Left when function throws', () {
        final Either<String, int> either = Either.tryCatch<String, int>(
          () => int.parse('invalid'),
          (e, s) => 'error',
        );
        expect(either.isLeft, isTrue);
        expect(either.leftValue, equals('error'));
      });

      test('passes error and stackTrace to onError callback', () {
        Object? capturedError;
        StackTrace? capturedStackTrace;

        final Either<String, int> either = Either.tryCatch<String, int>(
          () => throw const FormatException('Invalid format'),
          (e, s) {
            capturedError = e;
            capturedStackTrace = s;
            return 'error: $e';
          },
        );

        expect(either.isLeft, isTrue);
        expect(capturedError, isA<FormatException>());
        expect(capturedStackTrace, isNotNull);
        expect(either.leftValue, contains('error:'));
      });

      test('handles different exception types', () {
        final Either<String, int> either1 = Either.tryCatch<String, int>(
          () => throw ArgumentError('Invalid argument'),
          (e, s) => e.toString(),
        );

        final Either<String, int> either2 = Either.tryCatch<String, int>(
          () => throw StateError('Invalid state'),
          (e, s) => e.toString(),
        );

        expect(either1.isLeft, isTrue);
        expect(either2.isLeft, isTrue);
        expect(either1.leftValue, contains('Invalid argument'));
        expect(either2.leftValue, contains('Invalid state'));
      });
    });

    group('cond', () {
      test('returns Right when predicate is true', () {
        final Either<String, int> either = Either.cond<String, int>(
          true,
          () => 42,
          () => 'error',
        );
        expect(either.isRight, isTrue);
        expect(either.rightValue, equals(42));
      });

      test('returns Left when predicate is false', () {
        final Either<String, int> either = Either.cond<String, int>(
          false,
          () => 42,
          () => 'error',
        );
        expect(either.isLeft, isTrue);
        expect(either.leftValue, equals('error'));
      });
    });

    group('filterOrElse', () {
      test('keeps Right if predicate is true', () {
        const either = Either<String, int>.right(42);
        final Either<String, int> result = either.filterOrElse(
          (r) => r > 0,
          () => 'negative',
        );
        expect(result.isRight, isTrue);
        expect(result.rightValue, equals(42));
      });

      test('switches to Left if predicate is false', () {
        const either = Either<String, int>.right(-1);
        final Either<String, int> result = either.filterOrElse(
          (r) => r > 0,
          () => 'negative',
        );
        expect(result.isLeft, isTrue);
        expect(result.leftValue, equals('negative'));
      });

      test('leaves Left unchanged', () {
        const either = Either<String, int>.left('error');
        final Either<String, int> result = either.filterOrElse(
          (r) => r > 0,
          () => 'negative',
        );
        expect(result.isLeft, isTrue);
        expect(result.leftValue, equals('error'));
      });
    });

    group('tap', () {
      test('executes callback for Right', () {
        const either = Either<String, int>.right(42);
        var sideEffect = 0;
        either.tap((r) => sideEffect = r);
        expect(sideEffect, equals(42));
      });

      test('does not execute callback for Left', () {
        const either = Either<String, int>.left('error');
        var sideEffect = 0;
        either.tap((r) => sideEffect = r);
        expect(sideEffect, equals(0));
      });

      test('returns the original Right component', () {
        const either = Either<String, int>.right(42);
        final Either<String, int> result = either.tap((r) {});
        expect(result, equals(either));
        expect(identical(result, either), isTrue);
      });

      test('returns the original Left component', () {
        const either = Either<String, int>.left('error');
        final Either<String, int> result = either.tap((r) {});
        expect(result, equals(either));
        expect(identical(result, either), isTrue);
      });
    });
  });
}
