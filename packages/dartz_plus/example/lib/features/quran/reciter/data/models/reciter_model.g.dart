// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReciterModel _$ReciterModelFromJson(Map<String, dynamic> json) =>
    _ReciterModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      letter: json['letter'] as String,
      date: json['date'] as String,
      moshaf: MoshafModel.fromJson(json['moshaf'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReciterModelToJson(_ReciterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'letter': instance.letter,
      'date': instance.date,
      'moshaf': instance.moshaf,
    };

// **************************************************************************
// MapperGenerator
// **************************************************************************

extension ReciterModelToReciterEntityMapper on ReciterModel {
  ReciterEntity toReciterEntity() {
    return ReciterEntity(
      id: id,
      name: name,
      letter: letter,
      date: date,
      moshaf: moshaf.toMoshafEntity(),
    );
  }
}

extension ReciterEntityToReciterModelMapper on ReciterEntity {
  ReciterModel toReciterModel() {
    return ReciterModel(
      id: id,
      name: name,
      letter: letter,
      date: date,
      moshaf: moshaf.toMoshafModel(),
    );
  }
}
