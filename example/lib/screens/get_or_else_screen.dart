import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

import '../code_preview_widget.dart';

class GetOrElseScreen extends StatelessWidget {
  const GetOrElseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const success = Either<String, int>.right(42);
    const error = Either<String, int>.left('error');

    final code = '''
void main() {
  const success = Either<String, int>.right(42);
  const error = Either<String, int>.left('error');

  print(success.getOrElse(() => 0)); // 42
  print(error.getOrElse(() => 0));   // 0

  print(success.orElse(() => const Either.right(100))); // Right(42)
  print(error.orElse(() => const Either.right(100)));   // Right(100)
}
    ''';

    final buffer = StringBuffer();
    buffer.writeln('getOrElse:');
    buffer.writeln('  Success: ${success.getOrElse(() => 0)}');
    buffer.writeln('  Error: ${error.getOrElse(() => 0)}');

    buffer.writeln('\norElse:');
    final alt1 = success.orElse(() => const Either.right(100));
    buffer.writeln('  Success orElse: ${alt1.rightValue}');

    final alt2 = error.orElse(() => const Either.right(100));
    buffer.writeln('  Error orElse: ${alt2.rightValue}');

    return CodePreviewWidget(
      title: 'getOrElse & orElse',
      description: 'Demonstrates providing default values or fallback Eithers.',
      code: code,
      output: buffer.toString(),
    );
  }
}
