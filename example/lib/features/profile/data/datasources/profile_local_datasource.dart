import 'package:dartz_plus/dartz_plus.dart';

import '../dtos/profile_dto.dart';

class ProfileLocalDataSource {
  Future<Either<String, ProfileDto>> getProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return fake data
    return Right(
      const ProfileDto(
        id: '12345',
        username: 'username',
        email: 'email@gmail.com',
        avatarUrl: 'https://placehold.co/200x200/png',
      ),
    );
  }
}
