// ignore_for_file: invalid_annotation_target
import 'package:dartz_plus/dartz_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/moshaf_entity.dart';

part 'moshaf_model.freezed.dart';
part 'moshaf_model.g.dart';

@freezed
@Mapper(MoshafEntity)
abstract class MoshafModel with _$MoshafModel {
  const factory MoshafModel({
    required int id,
    required String name,
    required String server,
    @JsonKey(name: 'surah_total') required int surahTotal,
    @JsonKey(name: 'moshaf_type') required int moshafType,
    @JsonKey(name: 'surah_list') required String surahList,
  }) = _MoshafModel;

  factory MoshafModel.fromJson(Map<String, dynamic> json) =>
      _$MoshafModelFromJson(json);
}
