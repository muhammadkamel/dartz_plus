import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/foundation.dart';

part 'user_model.g.dart';

@Mapper(UserEntity)
class UserModel {
  final String name;
  final int age;
  UserModel({required this.name, required this.age});

  @override
  String toString() => 'UserModel(name: $name, age: $age)';
}

@immutable
class UserEntity {
  final String name;
  final int age;
  final String? email;

  const UserEntity(this.name, this.age, {this.email});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      // data from dummyjson usually has firstName/lastName
      '${json['firstName']} ${json['lastName']}',
      json['age'] as int,
      email: json['email'] as String?,
    );
  }

  @override
  String toString() => 'UserEntity(name: $name, age: $age)';
}
