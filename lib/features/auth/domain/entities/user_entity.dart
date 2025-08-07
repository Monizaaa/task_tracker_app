/// UserEntity represents the core user data in the domain layer.
/// It is immutable and defines the structure of a user.
class UserEntity {
  final int id;
  final String email;
  final String? displayName;
  final String? avatar;
  final String? username;

  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.avatar,
    this.username,
  });
}
