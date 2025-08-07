import 'package:task_tracker_app/features/auth/domain/entities/user_entity.dart';

class SigninResponseEntity {
  final String token;
  final UserEntity user;
  final String? message;

  const SigninResponseEntity({
    required this.token,
    required this.user,
    this.message,
  });
}
