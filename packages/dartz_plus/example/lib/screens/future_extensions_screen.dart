import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

import '../code_preview_widget.dart';

class FutureExtensionsScreen extends StatelessWidget {
  const FutureExtensionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _runDemo(),
      builder: (context, snapshot) {
        final code = '''
Future<Either<String, int>> fetchUserAge() async {
  await Future.delayed(const Duration(milliseconds: 100));
  return const Right(25);
}

Future<void> main() async {
  // 1. Map: Transform the value inside Future<Either>
  final nextYearAge = await fetchUserAge()
      .map((age) => age + 1);
      
  // 2. FlatMap: Chain async operations
  final message = await fetchUserAge()
      .flatMap((age) async => Right('User is \$age years old'));
      
  // 3. Fold: Handle both cases
  final result = await fetchUserAge().fold(
    (l) => 'Error: \$l',
    (r) => 'Success: \$r',
  );
  
  // 4. getOrThrow: Get value or throw exception
  try {
    final age = await fetchUserAge().getOrThrow();
    print(age);
  } catch (e) {
    print(e);
  }
}
        ''';

        return CodePreviewWidget(
          title: 'Future Extensions',
          description: 'Chain operations directly on Future<Either>.',
          code: code,
          output: snapshot.data,
          result: snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : null,
        );
      },
    );
  }

  Future<String> _runDemo() async {
    final buffer = StringBuffer();

    // Helper to simulate async fetch
    Future<Either<String, int>> fetchUserAge() async {
      await Future.delayed(const Duration(milliseconds: 50));
      return const Right(25);
    }

    Future<Either<String, int>> fetchError() async {
      await Future.delayed(const Duration(milliseconds: 50));
      return const Left('Fetch failed');
    }

    // 1. Map
    final nextYearAge = await fetchUserAge().map((age) => age + 1);
    buffer.writeln('1. map (Success):');
    buffer.writeln('   Original: 25');
    buffer.writeln('   Mapped: ${nextYearAge.rightValue}\n');

    // 2. FlatMap
    final message = await fetchUserAge().flatMap(
      (age) async => Right('User is $age years old'),
    );
    buffer.writeln('2. flatMap (Success):');
    buffer.writeln('   Result: ${message.rightValue}\n');

    // 3. MapLeft (Error case)
    final mappedError = await fetchError().mapLeft((l) => l.toUpperCase());
    buffer.writeln('3. mapLeft (Error):');
    buffer.writeln('   Original: Fetch failed');
    buffer.writeln('   Mapped: ${mappedError.leftValue}\n');

    // 4. Fold
    final foldResult = await fetchUserAge().fold(
      (l) => 'Error: $l',
      (r) => 'Success: $r',
    );
    buffer.writeln('4. fold:');
    buffer.writeln('   Result: $foldResult\n');

    // 5. getOrThrow
    buffer.writeln('5. getOrThrow:');
    try {
      final age = await fetchUserAge().getOrThrow();
      buffer.writeln('   Success: $age');
    } catch (e) {
      buffer.writeln('   Failed: $e');
    }

    try {
      await fetchError().getOrThrow();
    } catch (e) {
      buffer.writeln('   Error case caught: $e');
    }

    return buffer.toString();
  }
}
