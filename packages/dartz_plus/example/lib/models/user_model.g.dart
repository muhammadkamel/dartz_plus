// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

extension UserModelToUserEntityMapper on UserModel {
  UserEntity toUserEntity() {
    return UserEntity(name, age);
  }
}

extension UserEntityToUserModelMapper on UserEntity {
  UserModel toUserModel() {
    return UserModel(name: name, age: age);
  }
}
