part of '../dartz_plus.dart';

/// Extensions for [Future] of [Either] to simplify handling async [Either] results.
extension FutureEitherExtensions<L, R> on Future<Either<L, R>> {
  /// Maps the right value of the [Either] inside the [Future].
  Future<Either<L, T>> map<T>(T Function(R r) f) {
    return then((either) => either.map(f));
  }

  /// Maps the left value of the [Either] inside the [Future].
  Future<Either<T, R>> mapLeft<T>(T Function(L l) f) {
    return then((either) => either.mapLeft(f));
  }

  /// Chains a computation that returns an [Either] inside a [Future].
  Future<Either<L, T>> flatMap<T>(FutureOr<Either<L, T>> Function(R r) f) {
    return then((either) => either.foldAsync((l) => Left(l), (r) => f(r)));
  }

  /// Folds the [Either] inside the [Future].
  Future<T> fold<T>(
    FutureOr<T> Function(L l) left,
    FutureOr<T> Function(R r) right,
  ) {
    return then((either) => either.foldAsync(left, right));
  }

  /// Returns the right value if it exists, otherwise throws the exception
  /// returned by [onLeft] (or the left value itself if no function is provided).
  Future<R> getOrThrow([Object Function(L l)? onLeft]) {
    return then(
      (either) => either.fold((l) {
        if (onLeft != null) {
          // ignore: only_throw_errors
          throw onLeft(l);
        }
        if (l != null && (l is Error || l is Exception)) {
          // ignore: only_throw_errors
          throw l;
        }
        throw Exception(l.toString());
      }, (r) => r),
    );
  }
}
