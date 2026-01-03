import 'package:dartz_plus/dartz_plus.dart';

part 'advanced_mapping.g.dart';

@Mapper(AdvancedEntity, constructor: 'fromDto')
class AdvancedModel {
  @MapTo('fullName')
  final String name;

  @IgnoreMap()
  final String? secretId;

  final int status;

  AdvancedModel({required this.name, this.secretId, required this.status});

  @override
  String toString() =>
      'AdvancedModel(name: $name, secretId: $secretId, status: $status)';
}

class AdvancedEntity {
  final String fullName;
  final int status;
  final String? note;

  const AdvancedEntity.fromDto({
    required this.fullName,
    required this.status,
    this.note,
  });

  @override
  String toString() =>
      'AdvancedEntity(fullName: $fullName, status: $status, note: $note)';
}
