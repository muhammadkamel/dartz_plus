import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dartz Plus Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EitherExamplePage(),
    );
  }
}

class EitherExamplePage extends StatefulWidget {
  const EitherExamplePage({super.key});

  @override
  State<EitherExamplePage> createState() => _EitherExamplePageState();
}

class _EitherExamplePageState extends State<EitherExamplePage> {
  String _output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Dartz Plus Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Either Type Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _basicUsage,
              child: const Text('1. Basic Usage'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _errorHandling,
              child: const Text('2. Error Handling'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _transformation,
              child: const Text('3. Transformation (map, mapLeft, bimap)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _chaining,
              child: const Text('4. Chaining Operations (flatMap)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _getOrElse,
              child: const Text('5. getOrElse & orElse'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _asyncOperations,
              child: const Text('6. Async Operations'),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                _output.isEmpty
                    ? 'Click a button above to see examples'
                    : _output,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _basicUsage() {
    const success = Either<String, int>.right(42);
    const error = Either<String, int>.left('Something went wrong');

    final buffer = StringBuffer();
    buffer.writeln('=== Basic Usage ===\n');

    buffer.writeln('Success value:');
    buffer.writeln('  isRight: ${success.isRight}');
    buffer.writeln('  isLeft: ${success.isLeft}');
    buffer.writeln('  rightValue: ${success.rightValue}');
    buffer.writeln('  leftValue: ${success.leftValue}');

    buffer.writeln('\nError value:');
    buffer.writeln('  isRight: ${error.isRight}');
    buffer.writeln('  isLeft: ${error.isLeft}');
    buffer.writeln('  rightValue: ${error.rightValue}');
    buffer.writeln('  leftValue: ${error.leftValue}');

    setState(() => _output = buffer.toString());
  }

  void _errorHandling() {
    Either<String, int> divide(int a, int b) {
      if (b == 0) {
        return const Either.left('Division by zero');
      }
      return Either.right(a ~/ b);
    }

    final buffer = StringBuffer();
    buffer.writeln('=== Error Handling ===\n');

    final Either<String, int> result1 = divide(10, 2);
    final Either<String, int> result2 = divide(10, 0);

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

    setState(() => _output = buffer.toString());
  }

  void _transformation() {
    final buffer = StringBuffer();
    buffer.writeln('=== Transformation ===\n');

    // map - transform Right values
    const success = Either<String, int>.right(5);
    final Either<String, int> doubled = success.map((value) => value * 2);
    buffer.writeln('map:');
    buffer.writeln('  Original: ${success.rightValue}');
    buffer.writeln('  Doubled: ${doubled.rightValue}');

    // mapLeft - transform Left values
    const error = Either<String, int>.left('error');
    final Either<String, int> upperError = error.mapLeft(
      (msg) => msg.toUpperCase(),
    );
    buffer.writeln('\nmapLeft:');
    buffer.writeln('  Original: ${error.leftValue}');
    buffer.writeln('  Uppercase: ${upperError.leftValue}');

    // bimap - transform both sides
    const result = Either<String, int>.right(10);
    final Either<String, int> transformed = result.bimap(
      (left) => 'ERROR: ${left.toUpperCase()}',
      (right) => right * 3,
    );
    buffer.writeln('\nbimap:');
    buffer.writeln('  Original: ${result.rightValue}');
    buffer.writeln('  Transformed: ${transformed.rightValue}');

    setState(() => _output = buffer.toString());
  }

  void _chaining() {
    Either<String, int> divide(int a, int b) {
      if (b == 0) {
        return const Either.left('Division by zero');
      }
      return Either.right(a ~/ b);
    }

    Either<String, int> multiply(int a, int b) {
      return Either.right(a * b);
    }

    final buffer = StringBuffer();
    buffer.writeln('=== Chaining Operations ===\n');

    // Chain operations - if any step fails, error propagates
    final Either<String, int> result = divide(20, 2)
        .flatMap((value) => multiply(value, 3))
        .flatMap((value) => divide(value, 2));

    buffer.writeln('Chain: divide(20, 2) -> multiply(*3) -> divide(/2)');
    result.fold(
      (error) => buffer.writeln('  Error: $error'),
      (value) => buffer.writeln('  Result: $value'),
    );

    // Chain with error
    final Either<String, int> errorResult = divide(20, 2)
        .flatMap((value) => divide(value, 0)) // This will fail
        .flatMap((value) => multiply(value, 3));

    buffer.writeln(
      '\nChain with error: divide(20, 2) -> divide(/0) -> multiply(*3)',
    );
    errorResult.fold(
      (error) => buffer.writeln('  Error: $error'),
      (value) => buffer.writeln('  Result: $value'),
    );

    setState(() => _output = buffer.toString());
  }

  void _getOrElse() {
    final buffer = StringBuffer();
    buffer.writeln('=== getOrElse & orElse ===\n');

    // getOrElse - get value or provide default
    const success = Either<String, int>.right(42);
    const error = Either<String, int>.left('error');

    buffer.writeln('getOrElse:');
    buffer.writeln('  Success: ${success.getOrElse(() => 0)}');
    buffer.writeln('  Error: ${error.getOrElse(() => 0)}');

    // orElse - provide alternative Either
    buffer.writeln('\norElse:');
    final Either<String, int> alternative1 = success.orElse(
      () => const Either.right(100),
    );
    buffer.writeln('  Success orElse: ${alternative1.rightValue}');

    final Either<String, int> alternative2 = error.orElse(
      () => const Either.right(100),
    );
    buffer.writeln('  Error orElse: ${alternative2.rightValue}');

    final Either<String, int> alternative3 = error.orElse(
      () => const Either.left('new error'),
    );
    buffer.writeln('  Error orElse (Left): ${alternative3.leftValue}');

    setState(() => _output = buffer.toString());
  }

  Future<void> _asyncOperations() async {
    final buffer = StringBuffer();
    buffer.writeln('=== Async Operations ===\n');

    const either = Either<String, int>.right(5);

    // foldAsync accepts both sync and async functions
    final String result = await either.foldAsync(
      (error) => 'Error: $error', // Sync function
      (value) => Future.delayed(
        const Duration(milliseconds: 100),
        () => 'Computed: ${value * 2}',
      ), // Async function
    );

    buffer.writeln('foldAsync:');
    buffer.writeln('  Result: $result');

    // Async with error
    const errorEither = Either<String, int>.left('async error');
    final String errorResult = await errorEither.foldAsync(
      (error) => Future.value('Handled: $error'),
      (value) => 'Value: $value',
    );

    buffer.writeln('\nfoldAsync with error:');
    buffer.writeln('  Result: $errorResult');

    setState(() => _output = buffer.toString());
  }
}
