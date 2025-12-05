import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

import '../code_preview_widget.dart';

class AsyncScreen extends StatelessWidget {
  const AsyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _runDemo(),
      builder: (context, snapshot) {
        final code = '''
Future<void> main() async {
  const either = Either<String, int>.right(5);

  // Async function
  final result = await either.foldAsync(
    (e) => 'Error: \$e',
    (v) => Future.delayed(
      const Duration(milliseconds: 100),
      () => 'Computed: \${v * 2}',
    ),
  );
  print(result); // Computed: 10

  // Sync function (also works!)
  const syncEither = Either<String, int>.right(10);
  final syncResult = await syncEither.foldAsync(
    (e) => 'Error: \$e',        // Sync function
    (v) => 'Sync: \${v * 3}',  // Sync function
  );
  print(syncResult); // Sync: 30
}
        ''';

        return CodePreviewWidget(
          title: 'Async Operations',
          description: 'Demonstrates proper async handling with foldAsync.',
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
    const either = Either<String, int>.right(5);
    final result = await either.foldAsync(
      (e) => 'Error: $e',
      (v) => Future.delayed(
        const Duration(milliseconds: 100),
        () => 'Computed: ${v * 2}',
      ),
    );

    const errorEither = Either<String, int>.left('async error');
    final errorResult = await errorEither.foldAsync(
      (e) => Future.value('Handled: $e'),
      (v) => 'Value: $v',
    );

    // Demonstrate synchronous functions work too
    const syncEither = Either<String, int>.right(10);
    final syncResult = await syncEither.foldAsync(
      (e) => 'Error: $e', // Synchronous function
      (v) => 'Sync computed: ${v * 3}', // Synchronous function
    );

    const syncErrorEither = Either<String, int>.left('sync error');
    final syncErrorResult = await syncErrorEither.foldAsync(
      (e) => 'Handled sync: $e', // Synchronous function
      (v) => 'Value: $v',
    );

    final buffer = StringBuffer();
    buffer.writeln('foldAsync with async functions:');
    buffer.writeln('  Result: $result');
    buffer.writeln('\nfoldAsync with error (async):');
    buffer.writeln('  Result: $errorResult');
    buffer.writeln('\nfoldAsync with sync functions:');
    buffer.writeln('  Result: $syncResult');
    buffer.writeln('\nfoldAsync with error (sync):');
    buffer.writeln('  Result: $syncErrorResult');
    return buffer.toString();
  }
}
