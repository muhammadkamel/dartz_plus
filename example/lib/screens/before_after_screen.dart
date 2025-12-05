import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

import '../code_preview_widget.dart';

class BeforeAfterScreen extends StatelessWidget {
  const BeforeAfterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Map<String, dynamic> rawData = {'age': '20'};

    final code = '''
// BEFORE: Imperative with exceptions
try {
  final ageString = rawData['age'];
  if (ageString == null) throw Exception('Missing');
  final age = int.tryParse(ageString);
  if (age == null) throw Exception('NaN');
  if (age < 18) throw Exception('Minor');
  print('Success: User is \$age');
} catch (e) {
  print('Error: \$e');
}

// AFTER: Functional with Either
Either.fromNullable(rawData['age'], () => 'Missing')
    .flatMap((str) => Either.tryCatch(
          () => int.parse(str),
          (_, __) => 'NaN',
        ))
    .filterOrElse((age) => age >= 18, () => 'Minor')
    .map((age) => 'User is \$age')
    .fold(
      (e) => print('Error: \$e'),
      (s) => print('Success: \$s'),
    );
    ''';

    // Execution Logic
    final buffer = StringBuffer();
    buffer.writeln('Input Data: $rawData\n');

    // BEFORE
    buffer.writeln('--- BEFORE (Imperative) ---');
    try {
      final ageString = rawData['age'] as String?;
      if (ageString == null) throw Exception('Age is missing');
      final age = int.tryParse(ageString);
      if (age == null) throw Exception('Age is not a number');
      if (age < 18) throw Exception('User is a minor');
      buffer.writeln('Success: User is $age (Adult)');
    } catch (e) {
      buffer.writeln('Error: $e');
    }

    // AFTER
    buffer.writeln('\n--- AFTER (Functional) ---');
    final resultAfter =
        Either.fromNullable<String, String>(
              rawData['age'] as String?,
              () => 'Age is missing',
            )
            .flatMap(
              (str) => Either.tryCatch<String, int>(
                () => int.parse(str),
                (e, s) => 'Age is not a number',
              ),
            )
            .filterOrElse((age) => age >= 18, () => 'User is a minor')
            .map((age) => 'User is $age (Adult)');

    resultAfter.fold(
      (e) => buffer.writeln('Error: $e'),
      (s) => buffer.writeln('Success: $s'),
    );

    return CodePreviewWidget(
      title: 'Before vs After',
      description:
          'Comparing imperative exception handling vs functional chaining.',
      code: code,
      output: buffer.toString(),
    );
  }
}
