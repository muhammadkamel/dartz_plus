// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moshaf_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MoshafModel _$MoshafModelFromJson(Map<String, dynamic> json) => _MoshafModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  server: json['server'] as String,
  surahTotal: (json['surah_total'] as num).toInt(),
  moshafType: (json['moshaf_type'] as num).toInt(),
  surahList: json['surah_list'] as String,
);

Map<String, dynamic> _$MoshafModelToJson(_MoshafModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'server': instance.server,
      'surah_total': instance.surahTotal,
      'moshaf_type': instance.moshafType,
      'surah_list': instance.surahList,
    };

// **************************************************************************
// MapperGenerator
// **************************************************************************

extension MoshafModelToMoshafEntityMapper on MoshafModel {
  MoshafEntity toMoshafEntity() {
    return MoshafEntity(
      id: id,
      name: name,
      server: server,
      surahTotal: surahTotal,
      moshafType: moshafType,
      surahList: surahList,
    );
  }
}

extension MoshafEntityToMoshafModelMapper on MoshafEntity {
  MoshafModel toMoshafModel() {
    return MoshafModel(
      id: id,
      name: name,
      server: server,
      surahTotal: surahTotal,
      moshafType: moshafType,
      surahList: surahList,
    );
  }
}
