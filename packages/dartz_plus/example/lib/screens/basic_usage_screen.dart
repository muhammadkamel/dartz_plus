import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

import '../code_preview_widget.dart';

class BasicUsageScreen extends StatelessWidget {
  const BasicUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const success = Either<String, int>.right(42);
    const error = Either<String, int>.left('Something went wrong');

    final code = '''
void main() {
  const success = Either<String, int>.right(42);
  const error = Either<String, int>.left('Something went wrong');

  // Check which side
  print('Success isRight: \${success.isRight}'); // true
  print('Success isLeft: \${success.isLeft}');   // false
  
  // Get values
  print('Success value: \${success.rightValue}'); // 42
  print('Error value: \${error.leftValue}');      // Something went wrong
  
  // String representation
  print('Success: \$success'); // Right(42)
  print('Error: \$error');     // Left(Something went wrong)
}
    ''';

    final output =
        '''
Success value:
  isRight: ${success.isRight}
  isLeft: ${success.isLeft}
  rightValue: ${success.rightValue}
  leftValue: ${success.leftValue}
  toString(): $success

Error value:
  isRight: ${error.isRight}
  isLeft: ${error.isLeft}
  rightValue: ${error.rightValue}
  leftValue: ${error.leftValue}
  toString(): $error
    ''';

    return CodePreviewWidget(
      title: 'Basic Usage',
      description: 'Demonstrates creating and inspecting Either instances.',
      code: code,
      output: output,
    );
  }
}
