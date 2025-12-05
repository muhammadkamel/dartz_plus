import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

import '../code_preview_widget.dart';

class TransformationScreen extends StatelessWidget {
  const TransformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const success = Either<String, int>.right(5);
    final doubleVal = success.map((v) => v * 2);

    const error = Either<String, int>.left('error');
    final upperError = error.mapLeft((msg) => msg.toUpperCase());

    const result = Either<String, int>.right(10);
    final transformed = result.bimap(
      (l) => 'ERROR: \${l.toUpperCase()}',
      (r) => r * 3,
    );

    final code = '''
void main() {
  // map
  const success = Either<String, int>.right(5);
  final doubled = success.map((v) => v * 2);

  // mapLeft
  const error = Either<String, int>.left('error');
  final upperError = error.mapLeft((msg) => msg.toUpperCase());

  // bimap
  final result = Either<String, int>.right(10);
  final transformed = result.bimap(
    (l) => 'ERROR: \${l.toUpperCase()}',
    (r) => r * 3,
  );
}
    ''';

    final buffer = StringBuffer();
    buffer.writeln('map:');
    buffer.writeln('  Original: ${success.rightValue}');
    buffer.writeln('  Doubled: ${doubleVal.rightValue}');

    buffer.writeln('\nmapLeft:');
    buffer.writeln('  Original: ${error.leftValue}');
    buffer.writeln('  Uppercase: ${upperError.leftValue}');

    buffer.writeln('\nbimap:');
    buffer.writeln('  Original: ${result.rightValue}');
    buffer.writeln('  Transformed: ${transformed.rightValue}');

    return CodePreviewWidget(
      title: 'Transformation',
      description:
          'Demonstrates map, mapLeft, and bimap for transforming values.',
      code: code,
      output: buffer.toString(),
    );
  }
}
