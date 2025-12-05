import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

import '../code_preview_widget.dart';

class ChainingScreen extends StatelessWidget {
  const ChainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Either<String, int> divide(int a, int b) {
      return b == 0
          ? const Either.left('Division by zero')
          : Either.right(a ~/ b);
    }

    Either<String, int> multiply(int a, int b) => Either.right(a * b);

    final result = divide(
      20,
      2,
    ).flatMap((v) => multiply(v, 3)).flatMap((v) => divide(v, 2));

    final errorResult = divide(
      20,
      2,
    ).flatMap((v) => divide(v, 0)).flatMap((v) => multiply(v, 3));

    final code = '''
void main() {
  // Chain: divide(20, 2) -> multiply(*3) -> divide(/2)
  final result = divide(20, 2)
      .flatMap((v) => multiply(v, 3))
      .flatMap((v) => divide(v, 2));

  // Chain with error: divide(20, 2) -> divide(/0) -> multiply(*3)
  final errorResult = divide(20, 2)
      .flatMap((v) => divide(v, 0))
      .flatMap((v) => multiply(v, 3));
}
    ''';

    final buffer = StringBuffer();
    buffer.writeln('Chain 1:');
    result.fold(
      (e) => buffer.writeln('  Error: $e'),
      (v) => buffer.writeln('  Result: $v'),
    );

    buffer.writeln('\nChain 2 (with error):');
    errorResult.fold(
      (e) => buffer.writeln('  Error: $e'),
      (v) => buffer.writeln('  Result: $v'),
    );

    return CodePreviewWidget(
      title: 'Chaining (flatMap)',
      description:
          'Demonstrates chaining operations where failure stops the chain.',
      code: code,
      output: buffer.toString(),
    );
  }
}
