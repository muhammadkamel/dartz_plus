import 'package:dartz_plus/dartz_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/reciter_entity.dart';
import 'moshaf_model.dart';

part 'reciter_model.freezed.dart';
part 'reciter_model.g.dart';

@freezed
@Mapper(ReciterEntity)
abstract class ReciterModel with _$ReciterModel {
  const factory ReciterModel({
    required int id,
    required String name,
    required String letter,
    required String date,
    required MoshafModel moshaf,
  }) = _ReciterModel;

  factory ReciterModel.fromJson(Map<String, dynamic> json) =>
      _$ReciterModelFromJson(json);
}
