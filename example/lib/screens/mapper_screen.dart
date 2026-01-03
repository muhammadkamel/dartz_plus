import 'package:flutter/material.dart';

import '../code_preview_widget.dart';
import '../models/user_model.dart';

class MapperScreen extends StatefulWidget {
  const MapperScreen({super.key});

  @override
  State<MapperScreen> createState() => _MapperScreenState();
}

class _MapperScreenState extends State<MapperScreen> {
  String? _output;

  @override
  void initState() {
    super.initState();
  }

  void _runDemo() {
    final buffer = StringBuffer();

    // 1. Code Generation Demo (Extension-based Mapper)
    // Annotate model with @Mapper(Target, reverse: true) to generate toTarget() and toSource() extensions.

    final genUser = UserEntity('Generator', 100, email: 'gen@test.com');
    try {
      // 1. Map UserEntity -> UserModel (Reverse Map)
      final model = genUser.toUserModel();

      // 2. Map UserModel -> UserEntity (Forward Map)
      final userBack = model.toUserEntity();

      buffer.writeln('1. Extension-based Mapping:');
      buffer.writeln('   UserEntity -> UserModel: $model');
      buffer.writeln('   UserModel -> UserEntity: $userBack');
    } catch (e) {
      buffer.writeln('Error in mapper mapping: $e');
    }

    setState(() {
      _output = buffer.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    const code = '''
// 1. Definition (user_model.dart)
@Mapper(UserEntity)
class UserModel { ... }

class UserEntity { ... }

// 2. Usage
final entity = UserEntity('Name', 30, email: 'test@example.com');
final model = entity.toUserModel();
final entityBack = model.toUserEntity();
    ''';

    return CodePreviewWidget(
      title: 'AutoMap Extensions',
      description:
          'Type-safe object mapping using generated extension methods.',
      code: code,
      output: _output,
      result: Center(
        child: ElevatedButton(
          onPressed: _runDemo,
          child: const Text('Run Mapping Demo'),
        ),
      ),
    );
  }
}
