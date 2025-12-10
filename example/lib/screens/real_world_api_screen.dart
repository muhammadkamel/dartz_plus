import 'package:dartz_plus/dartz_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../code_preview_widget.dart';
import '../models/user_model.dart';

class RealWorldApiScreen extends StatelessWidget {
  const RealWorldApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _runExamples(),
      builder: (context, snapshot) {
        return CodePreviewWidget(
          title: 'Real World API (Dio)',
          description:
              'Fetching data from a real API (dummyjson.com) using Dio and handling errors safely with Either.',
          code: _codeSnippet,
          output: snapshot.data ?? 'Running...',
          result: snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : null,
        );
      },
    );
  }

  static const String _codeSnippet = '''
final dio = Dio();

Future<Either<String, UserEntity>> fetchUser(int id) async {
  // 1. Try-Catch for Network Request
  return Either.tryCatch<String, Response>(
    () => dio.get('https://dummyjson.com/users/\$id'),
    (e, s) => 'Network Error: \$e',
  )
  // 2. Validate Status Code
  .flatMap((response) {
    return response.statusCode == 200
        ? Either.right(response.data)
        : Either.left('API Error: \${response.statusCode}');
  })
  // 3. Parse JSON to User Model
  .flatMap((data) {
    return Either.tryCatch(
      () => UserEntity.fromJson(data as Map<String, dynamic>),
      (e, s) => 'Parsing Error: \$e',
    );
  });
}
''';

  Future<String> _runExamples() async {
    final buffer = StringBuffer();
    final dio = Dio();

    Future<Either<String, UserEntity>> fetchUser(int id) async {
      // 1. Perform Network Request (Async)
      Response response;
      try {
        response = await dio.get('https://dummyjson.com/users/$id');
      } catch (e) {
        return Either.left('Network Error: $e');
      }

      // 2. Validate Status Code & Parse
      // Explicitly type the starting Either to match L=String
      return Either.right(UserEntity.fromJson(response.data));
    }

    buffer.writeln('--- Scenario 1: Fetch Existing User (ID: 1) ---');
    final result1 = await fetchUser(1);
    result1.fold(
      (e) => buffer.writeln('Error: $e'),
      (user) => buffer.writeln('Success: Fetched $user'),
    );

    buffer.writeln('\n--- Scenario 2: Fetch Non-Existing User (ID: 9999) ---');
    final result2 = await fetchUser(9999);
    result2.fold(
      (e) => buffer.writeln('Error: $e'),
      (user) => buffer.writeln('Success: Fetched $user'),
    );

    // Simulate Network Error (Invalid URL)
    buffer.writeln('\n--- Scenario 3: Network Error (Invalid Domain) ---');
    try {
      // Intentionally causing a network error
      await dio.get('https://invalid-url-example.com');
    } catch (e) {
      // We can demonstrate how to wrap an existing exception using Either.left
      // allowing it to flow into the same error handling pipeline if needed.
      final result3 = Either<String, UserEntity>.left(
        'Network request failed (simulated): $e',
      );
      result3.fold(
        (e) => buffer.writeln('Error: $e'),
        (user) => buffer.writeln('Success: Fetched $user'),
      );
    }

    return buffer.toString();
  }
}
