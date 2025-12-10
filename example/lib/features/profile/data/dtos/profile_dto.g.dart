// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'profile_dto.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

extension ProfileDtoToProfileEntityMapper on ProfileDto {
  ProfileEntity toProfileEntity() {
    return ProfileEntity(
      id: id,
      username: username,
      email: email,
      avatarUrl: avatarUrl,
    );
  }
}

extension ProfileEntityToProfileDtoMapper on ProfileEntity {
  ProfileDto toProfileDto() {
    return ProfileDto(
      id: id,
      username: username,
      email: email,
      avatarUrl: avatarUrl,
    );
  }
}
