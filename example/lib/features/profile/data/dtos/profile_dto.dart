import 'package:dartz_plus/dartz_plus.dart';

import '../../domain/entities/profile_entity.dart';

part 'profile_dto.g.dart';

@Mapper(ProfileEntity)
class ProfileDto {
  final String id;
  final String username;
  final String email;
  final String avatarUrl;

  const ProfileDto({
    required this.id,
    required this.username,
    required this.email,
    required this.avatarUrl,
  });

  @override
  String toString() => 'ProfileDto($username)';
}
