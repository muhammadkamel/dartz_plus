import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

import '../code_preview_widget.dart';

class FPEnhancementsScreen extends StatelessWidget {
  const FPEnhancementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final code = '''
void main() {
  // 1. fromNullable
  final e1 = Either.fromNullable(null, () => 'null');
  final e1Success = Either.fromNullable(42, () => 'null');

  // 2. tryCatch (with error and stackTrace)
  Object? error;
  StackTrace? stackTrace;
  final e2 = Either.tryCatch(
    () => int.parse('invalid'),
    (e, s) {
      error = e;
      stackTrace = s;
      return 'parse error: \${e.runtimeType}';
    },
  );

  // 3. cond
  final e3 = Either.cond(true, () => 'Valid', () => 'Invalid');
  final e3False = Either.cond(false, () => 'Valid', () => 'Invalid');

  // 4. filterOrElse
  final e4 = Either.right(10).filterOrElse(
    (v) => v > 5,
    () => 'Too small',
  );
  final e4Fail = Either.right(3).filterOrElse(
    (v) => v > 5,
    () => 'Too small',
  );

  // 5. tap
  Either.right(100).tap((v) => print('Side effect: \$v'));
}
    ''';

    final buffer = StringBuffer();

    // 1. fromNullable
    buffer.writeln('1. fromNullable:');
    buffer.writeln('  null -> ${Either.fromNullable(null, () => 'null')}');
    final fromNullableSuccess = Either.fromNullable<String, int>(
      42,
      () => 'null',
    );
    buffer.writeln('  42 -> $fromNullableSuccess');

    // 2. tryCatch
    buffer.writeln('2. tryCatch:');
    Object? capturedError;
    StackTrace? capturedStackTrace;
    final failParse = Either.tryCatch<String, int>(() => int.parse('abc'), (
      e,
      s,
    ) {
      capturedError = e;
      capturedStackTrace = s;
      return 'parse error: ${e.runtimeType}';
    });
    buffer.writeln('  parse("abc") -> $failParse');
    buffer.writeln('  Error type: ${capturedError.runtimeType}');
    buffer.writeln('  StackTrace available: ${capturedStackTrace != null}');

    final successParse = Either.tryCatch<String, int>(
      () => int.parse('42'),
      (e, s) => 'parse error',
    );
    buffer.writeln('  parse("42") -> $successParse');

    // 3. cond
    buffer.writeln('3. cond:');
    final condRes = Either.cond<String, String>(
      true,
      () => 'Valid',
      () => 'Invalid',
    );
    buffer.writeln('  true -> $condRes');
    final condResFalse = Either.cond<String, String>(
      false,
      () => 'Valid',
      () => 'Invalid',
    );
    buffer.writeln('  false -> $condResFalse');

    // 4. filterOrElse
    buffer.writeln('4. filterOrElse:');
    final filtered = Either<String, int>.right(
      10,
    ).filterOrElse((v) => v > 5, () => 'Too small');
    buffer.writeln('  10 > 5 -> $filtered');
    final filteredFail = Either<String, int>.right(
      3,
    ).filterOrElse((v) => v > 5, () => 'Too small');
    buffer.writeln('  3 > 5 -> $filteredFail');
    final filteredLeft = Either<String, int>.left(
      'error',
    ).filterOrElse((v) => v > 5, () => 'Too small');
    buffer.writeln('  Left unchanged -> $filteredLeft');

    // 5. tap
    buffer.writeln('5. tap:');
    int sideEffect = 0;
    Either<String, int>.right(100).tap((v) => sideEffect = v);
    buffer.writeln('  Side effect value: $sideEffect');

    return CodePreviewWidget(
      title: 'FP Enhancements',
      description: 'Demonstrates new functional programming utilities.',
      code: code,
      output: buffer.toString(),
    );
  }
}
