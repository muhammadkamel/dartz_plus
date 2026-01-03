import 'package:dartz_plus/dartz_plus.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/profile_local_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Dependency Injection (Manual for demo)
  late final ProfileRepository _repository;

  Either<String, ProfileEntity>? _profileData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final dataSource = ProfileLocalDataSource();
    _repository = ProfileRepositoryImpl(dataSource);
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    final result = await _repository.getProfile();
    setState(() {
      _profileData = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _profileData?.fold(
                    (error) => Text(
                      'Error: $error',
                      style: const TextStyle(color: Colors.red),
                    ),
                    (profile) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(profile.avatarUrl),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          profile.username,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          profile.email,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Mapped from ProfileEntity via Clean Architecture!',
                        ),
                      ],
                    ),
                  ) ??
                  const Text('No Data'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadProfile,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
