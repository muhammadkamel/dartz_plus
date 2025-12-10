import 'package:dartz_plus/dartz_plus.dart';

part 'user_model.g.dart';

@Mapper(User)
class UserDto {
  final String name;
  final int age;
  UserDto({required this.name, required this.age});

  @override
  String toString() => 'UserDto(name: $name, age: $age)';
}

@Mapper(UserDto)
class User {
  final String name;
  final int age;
  User(this.name, this.age);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // data from dummyjson usually has firstName/lastName
      '${json['firstName']} ${json['lastName']}',
      json['age'] as int,
    );
  }

  @override
  String toString() => 'User(name: $name, age: $age)';
}

@Mapper(UserEntity)
class UserEntity {
  final String name;
  final int age;
  UserEntity(this.name, this.age);

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      // data from dummyjson usually has firstName/lastName
      '${json['firstName']} ${json['lastName']}',
      json['age'] as int,
    );
  }

  @override
  String toString() => 'User(name: $name, age: $age)';
}
