import 'package:dartz_plus/dartz_plus.dart';

import '../models/profile_model.dart';

class ProfileLocalDataSource {
  Future<Either<String, ProfileModel>> getProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return fake data
    return Right(
      const ProfileModel(
        id: '12345',
        username: 'username',
        email: 'email@gmail.com',
        avatarUrl: 'https://placehold.co/200x200/png',
      ),
    );
  }
}
