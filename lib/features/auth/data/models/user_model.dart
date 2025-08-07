import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.avatar,
    super.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: int.tryParse(data['id'].toString()) ?? 0,
      email: data['email'] as String,
      displayName: data['displayName'] as String?,
      avatar: data['avatar'] as String?,
      username: data['username'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'avatar': avatar,
      'username': username,
    };
  }
}
