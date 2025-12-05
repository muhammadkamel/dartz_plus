import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// A type that represents a value of one of two possible types (a disjoint union).
///
/// An instance of [Either] is either a [Left] containing a value of type [L],
/// or a [Right] containing a value of type [R].
@immutable
sealed class Either<L, R> extends Equatable {
  const Either();

  /// Creates a [Left] instance containing the given value.
  const factory Either.left(L value) = Left<L, R>;

  /// Creates a [Right] instance containing the given value.
  const factory Either.right(R value) = Right<L, R>;

  /// Creates an [Either] from a nullable value.
  ///
  /// If [value] is non-null, returns a [Right] containing the value.
  /// If [value] is null, returns a [Left] containing the result of [onNull].
  static Either<L, R> fromNullable<L, R>(R? value, L Function() onNull) {
    return value != null ? Right(value) : Left(onNull());
  }

  /// Executes [run] and captures any exception as a [Left].
  ///
  /// If [run] returns successfully, returns a [Right] containing the result.
  /// If [run] throws, returns a [Left] containing the result of [onError].
  static Either<L, R> tryCatch<L, R>(
    R Function() run,
    L Function(Object error, StackTrace stackTrace) onError,
  ) {
    try {
      return Right(run());
    } catch (error, stackTrace) {
      return Left(onError(error, stackTrace));
    }
  }

  /// Creates an [Either] based on a predicate.
  ///
  /// If [predicate] is true, returns a [Right] containing the result of [onTrue].
  /// If [predicate] is false, returns a [Left] containing the result of [onFalse].
  static Either<L, R> cond<L, R>(
    bool predicate,
    R Function() onTrue,
    L Function() onFalse,
  ) {
    return predicate ? Right(onTrue()) : Left(onFalse());
  }

  /// Returns `true` if this is a [Left] instance.
  bool get isLeft => this is Left<L, R>;

  /// Returns `true` if this is a [Right] instance.
  bool get isRight => this is Right<L, R>;

  /// Applies the appropriate function based on whether this is a [Left] or [Right].
  ///
  /// If this is a [Left], applies [left] to its value.
  /// If this is a [Right], applies [right] to its value.
  T fold<T>(T Function(L l) left, T Function(R r) right) {
    return switch (this) {
      Left(value: final l) => left(l),
      Right(value: final r) => right(r),
    };
  }

  /// Async version of [fold].
  ///
  /// Applies the appropriate async function based on whether this is a [Left] or [Right].
  Future<T> foldAsync<T>(
    FutureOr<T> Function(L l) left,
    FutureOr<T> Function(R r) right,
  ) async {
    return switch (this) {
      Left(value: final l) => await left(l),
      Right(value: final r) => await right(r),
    };
  }

  /// Swaps the left and right types.
  ///
  /// Converts a [Left] to a [Right] and vice versa.
  Either<R, L> swap() {
    return switch (this) {
      Left(value: final l) => Right(l),
      Right(value: final r) => Left(r),
    };
  }

  /// Returns the left value if this is a [Left], otherwise returns `null`.
  L? get leftValue => switch (this) {
    Left(value: final l) => l,
    Right() => null,
  };

  /// Returns the right value if this is a [Right], otherwise returns `null`.
  R? get rightValue => switch (this) {
    Right(value: final r) => r,
    Left() => null,
  };

  /// Transforms the [Right] value using the given function.
  ///
  /// If this is a [Left], returns it unchanged.
  /// If this is a [Right], applies [f] to the value and wraps it in a new [Right].
  Either<L, T> map<T>(T Function(R r) f) {
    return switch (this) {
      Left(value: final l) => Left(l),
      Right(value: final r) => Right(f(r)),
    };
  }

  /// Transforms the [Left] value using the given function.
  ///
  /// If this is a [Right], returns it unchanged.
  /// If this is a [Left], applies [f] to the value and wraps it in a new [Left].
  Either<T, R> mapLeft<T>(T Function(L l) f) {
    return switch (this) {
      Left(value: final l) => Left(f(l)),
      Right(value: final r) => Right(r),
    };
  }

  /// Transforms both [Left] and [Right] values using the given functions.
  ///
  /// If this is a [Left], applies [left] to the value and wraps it in a new [Left].
  /// If this is a [Right], applies [right] to the value and wraps it in a new [Right].
  Either<L2, R2> bimap<L2, R2>(L2 Function(L l) left, R2 Function(R r) right) {
    return switch (this) {
      Left(value: final l) => Left(left(l)),
      Right(value: final r) => Right(right(r)),
    };
  }

  /// Chains [Either] operations (flatMap/bind).
  ///
  /// If this is a [Left], returns it unchanged.
  /// If this is a [Right], applies [f] to the value and returns the result.
  Either<L, T> flatMap<T>(Either<L, T> Function(R r) f) {
    return switch (this) {
      Left(value: final l) => Left(l),
      Right(value: final r) => f(r),
    };
  }

  /// Returns the right value if this is a [Right], otherwise returns the result of [orElse].
  R getOrElse(R Function() orElse) {
    return switch (this) {
      Left() => orElse(),
      Right(value: final r) => r,
    };
  }

  /// Returns this [Either] if it's a [Right], otherwise returns the result of [alternative].
  Either<L, R> orElse(Either<L, R> Function() alternative) {
    return switch (this) {
      Left() => alternative(),
      Right() => this,
    };
  }

  /// Returns a [Right] if this is a [Right] and the value satisfies [predicate],
  /// otherwise returns a [Left].
  ///
  /// If this is a [Left], returns it unchanged.
  /// If this is a [Right] and [predicate] returns true, returns this.
  /// If this is a [Right] and [predicate] returns false, returns a [Left]
  /// containing the result of [onFalse].
  Either<L, R> filterOrElse(
    bool Function(R r) predicate,
    L Function() onFalse,
  ) {
    return switch (this) {
      Left() => this,
      Right(value: final r) => predicate(r) ? this : Left(onFalse()),
    };
  }

  /// Executes [f] if this is a [Right] and returns this [Either] unchanged.
  ///
  /// Useful for side effects like logging or debugging.
  /// Example:
  /// ```dart
  /// Either<String, int>.right(42)
  ///   .tap((value) => print('Got value: $value'))
  ///   .map((value) => value * 2);
  /// ```
  Either<L, R> tap(void Function(R r) f) {
    switch (this) {
      case Right(value: final r):
        f(r);
        return this;
      case Left():
        return this;
    }
  }
}

/// The left side of an [Either], representing an error or failure case.
class Left<L, R> extends Either<L, R> {
  /// Creates a [Left] instance with the given value.
  const Left(this.value);

  /// The value contained in this [Left] instance.
  final L value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Left($value)';
}

/// The right side of an [Either], representing a success case.
class Right<L, R> extends Either<L, R> {
  /// Creates a [Right] instance with the given value.
  const Right(this.value);

  /// The value contained in this [Right] instance.
  final R value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Right($value)';
}
