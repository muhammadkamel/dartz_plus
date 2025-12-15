import 'package:dartz_plus/dartz_plus.dart';

import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<String, ProfileEntity>> getProfile();
}
