import 'package:dartz_plus/dartz_plus.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../dtos/profile_dto.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  Future<Either<String, ProfileEntity>> getProfile() async {
    final result = await _dataSource.getProfile();
    return result.map((dto) => dto.toProfileEntity());
  }
}
