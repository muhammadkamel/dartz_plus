import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

import '../code_preview_widget.dart';

class SwapScreen extends StatelessWidget {
  const SwapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const leftEither = Either<String, int>.left('error');
    final swappedToRight = leftEither.swap();

    const rightEither = Either<String, int>.right(42);
    final swappedToLeft = rightEither.swap();

    // Double swap returns to original
    final doubleSwapped = swappedToRight.swap();

    final code = '''
void main() {
  // Swap Left to Right
  const leftEither = Either<String, int>.left('error');
  final swappedToRight = leftEither.swap();
  // Now Either<int, String>.right('error')
  
  // Swap Right to Left
  const rightEither = Either<String, int>.right(42);
  final swappedToLeft = rightEither.swap();
  // Now Either<int, String>.left(42)
  
  // Double swap returns to original
  final doubleSwapped = swappedToRight.swap();
  // Back to Either<String, int>.left('error')
  
  print('Original: \$leftEither');
  print('Swapped: \$swappedToRight');
  print('Double swapped: \$doubleSwapped');
}
    ''';

    final buffer = StringBuffer();
    buffer.writeln('Original Left:');
    buffer.writeln('  Type: ${leftEither.runtimeType}');
    buffer.writeln('  Value: ${leftEither.leftValue}');
    buffer.writeln('  toString(): $leftEither');

    buffer.writeln('\nAfter swap():');
    buffer.writeln('  Type: ${swappedToRight.runtimeType}');
    buffer.writeln('  isRight: ${swappedToRight.isRight}');
    buffer.writeln('  rightValue: ${swappedToRight.rightValue}');
    buffer.writeln('  toString(): $swappedToRight');

    buffer.writeln('\n---');

    buffer.writeln('\nOriginal Right:');
    buffer.writeln('  Type: ${rightEither.runtimeType}');
    buffer.writeln('  Value: ${rightEither.rightValue}');
    buffer.writeln('  toString(): $rightEither');

    buffer.writeln('\nAfter swap():');
    buffer.writeln('  Type: ${swappedToLeft.runtimeType}');
    buffer.writeln('  isLeft: ${swappedToLeft.isLeft}');
    buffer.writeln('  leftValue: ${swappedToLeft.leftValue}');
    buffer.writeln('  toString(): $swappedToLeft');

    buffer.writeln('\n---');

    buffer.writeln('\nDouble swap (back to original):');
    buffer.writeln('  Type: ${doubleSwapped.runtimeType}');
    buffer.writeln('  isLeft: ${doubleSwapped.isLeft}');
    buffer.writeln('  leftValue: ${doubleSwapped.leftValue}');
    buffer.writeln('  toString(): $doubleSwapped');
    buffer.writeln(
      '  Equal to original: ${doubleSwapped.leftValue == leftEither.leftValue}',
    );

    return CodePreviewWidget(
      title: 'Swap',
      description:
          'Demonstrates swapping Left and Right types. Useful when you need to flip error and success types.',
      code: code,
      output: buffer.toString(),
    );
  }
}
