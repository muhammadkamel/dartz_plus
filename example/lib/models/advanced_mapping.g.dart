// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advanced_mapping.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

extension AdvancedModelToAdvancedEntityMapper on AdvancedModel {
  AdvancedEntity toAdvancedEntity() {
    return AdvancedEntity.fromDto(fullName: name, status: status);
  }
}

extension AdvancedEntityToAdvancedModelMapper on AdvancedEntity {
  AdvancedModel toAdvancedModel() {
    return AdvancedModel(name: fullName, status: status);
  }
}
