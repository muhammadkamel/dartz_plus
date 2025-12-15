// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'user_model.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

extension UserDtoToUserEntityMapper on UserDto {
  UserEntity toUserEntity() {
    return UserEntity(name, age);
  }
}

extension UserEntityToUserDtoMapper on UserEntity {
  UserDto toUserDto() {
    return UserDto(name: name, age: age);
  }
}
