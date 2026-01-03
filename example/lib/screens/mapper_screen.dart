import 'package:flutter/material.dart';

import '../code_preview_widget.dart';
import '../models/advanced_mapping.dart';
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

    // 1. Basic Mapping Demo
    final genUser = UserEntity('Basic User', 25, email: 'basic@test.com');
    try {
      final model = genUser.toUserModel();
      final userBack = model.toUserEntity();

      buffer.writeln('1. Basic Mapping:');
      buffer.writeln('   UserEntity -> UserModel: $model');
      buffer.writeln('   UserModel -> UserEntity: $userBack');
      buffer.writeln('');
    } catch (e) {
      buffer.writeln('Error in basic mapping: $e\n');
    }

    // 2. Advanced Mapping Demo (@MapTo, @IgnoreMap, Custom Constructor)
    final advancedModel = AdvancedModel(
      name: 'Advanced Feature',
      secretId: 'INTERNAL_SECRET',
      status: 1,
    );

    try {
      final entity = advancedModel.toAdvancedEntity();
      final modelBack = entity.toAdvancedModel();

      buffer.writeln('2. Advanced Mapping (@MapTo & Custom Ctor):');
      buffer.writeln('   AdvancedModel (name) -> AdvancedEntity (fullName)');
      buffer.writeln('   Source: $advancedModel');
      buffer.writeln('   Target: $entity');
      buffer.writeln('   Back:   $modelBack (secretId is null as ignored)');
    } catch (e) {
      buffer.writeln('Error in advanced mapping: $e');
    }

    setState(() {
      _output = buffer.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    const code = '''
// 1. Basic Mapping
@Mapper(UserEntity)
class UserModel { ... }

// 2. Advanced Mapping
@Mapper(AdvancedEntity, constructor: 'fromDto')
class AdvancedModel {
  @MapTo('fullName')
  final String name;

  @IgnoreMap()
  final String? secretId;

  final int status;
}

// Usage
final model = AdvancedModel(name: 'Test', status: 1);
final entity = model.toAdvancedEntity(); // Uses .fromDto(fullName: name, ...)
    ''';

    return CodePreviewWidget(
      title: 'AutoMap Enhancements',
      description:
          'Advanced object mapping with @MapTo, @IgnoreMap, and custom constructor support.',
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
