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
    // Annotate model with @Mapper(Target) to generate toTarget() extension.

    final genUser = User('Generator', 100);
    try {
      // 1. Map User -> UserDto
      final dto = genUser.toUserDto();

      // 2. Map UserDto -> User
      final userBack = dto.toUser();

      buffer.writeln('1. Extension-based Mapping:');
      buffer.writeln('   User -> UserDto: $dto');
      buffer.writeln('   UserDto -> User: $userBack');
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
@Mapper(UserDto)
class User { ... }

@Mapper(User)
class UserDto { ... }

// 2. Usage
final user = User('Name', 30);
final dto = user.toUserDto();
final userBack = dto.toUser();
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
