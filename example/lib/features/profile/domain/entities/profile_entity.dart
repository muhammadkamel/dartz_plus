import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String username;
  final String email;
  final String avatarUrl;

  const ProfileEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, username, email, avatarUrl];
}
