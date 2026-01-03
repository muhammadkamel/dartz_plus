import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

import '../code_preview_widget.dart';

class ErrorHandlingScreen extends StatelessWidget {
  const ErrorHandlingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Either<String, int> divide(int a, int b) {
      if (b == 0) {
        return const Either.left('Division by zero');
      }
      return Either.right(a ~/ b);
    }

    final code = '''
Either<String, int> divide(int a, int b) {
  if (b == 0) {
    return const Either.left('Division by zero');
  }
  return Either.right(a ~/ b);
}

void main() {
  final result1 = divide(10, 2);
  final result2 = divide(10, 0);

  result1.fold(
    (e) => print('Error: \$e'),
    (v) => print('Result: \$v'),
  );

  result2.fold(
    (e) => print('Error: \$e'),
    (v) => print('Result: \$v'),
  );
}
    ''';

    final result1 = divide(10, 2);
    final result2 = divide(10, 0);

    final buffer = StringBuffer();
    buffer.writeln('divide(10, 2):');
    result1.fold(
      (error) => buffer.writeln('  Error: $error'),
      (value) => buffer.writeln('  Result: $value'),
    );

    buffer.writeln('\ndivide(10, 0):');
    result2.fold(
      (error) => buffer.writeln('  Error: $error'),
      (value) => buffer.writeln('  Result: $value'),
    );

    return CodePreviewWidget(
      title: 'Error Handling',
      description:
          'Demonstrates returning Left for errors and Right for success.',
      code: code,
      output: buffer.toString(),
    );
  }
}
