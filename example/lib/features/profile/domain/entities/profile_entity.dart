class ProfileEntity {
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
  String toString() =>
      'ProfileEntity(id: $id, username: $username, email: $email)';
}
