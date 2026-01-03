// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
    };

// **************************************************************************
// MapperGenerator
// **************************************************************************

extension ProfileModelToProfileEntityMapper on ProfileModel {
  ProfileEntity toProfileEntity() {
    return ProfileEntity(
      id: id,
      username: username,
      email: email,
      avatarUrl: avatarUrl,
    );
  }
}

extension ProfileEntityToProfileModelMapper on ProfileEntity {
  ProfileModel toProfileModel() {
    return ProfileModel(
      id: id,
      username: username,
      email: email,
      avatarUrl: avatarUrl,
    );
  }
}
