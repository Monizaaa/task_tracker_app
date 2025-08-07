import 'package:task_tracker_app/features/auth/domain/entities/signin_response_entity.dart';

class SigninResponseModel extends SigninResponseEntity {
  const SigninResponseModel({
    required super.token,
    required super.user,
    super.message,
  });
}
