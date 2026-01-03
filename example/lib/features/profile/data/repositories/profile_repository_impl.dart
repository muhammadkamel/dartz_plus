import 'package:dartz_plus/dartz_plus.dart';
import 'package:dartz_plus_example/features/profile/data/models/profile_model.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  Future<Either<String, ProfileEntity>> getProfile() async {
    final result = await _dataSource.getProfile();
    return result.map((model) => model.toProfileEntity());
  }
}
