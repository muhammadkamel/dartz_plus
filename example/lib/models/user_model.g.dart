// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'user_model.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

extension UserDtoToUserMapper on UserDto {
  User toUser() {
    return User(name, age);
  }
}

extension UserToUserDtoMapper on User {
  UserDto toUserDto() {
    return UserDto(name: name, age: age);
  }
}

extension UserEntityToUserEntityMapper on UserEntity {
  UserEntity toUserEntity() {
    return UserEntity(name, age);
  }
}
