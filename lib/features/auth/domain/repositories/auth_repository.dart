import 'package:task_tracker_app/features/auth/domain/entities/signin_response_entity.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<SigninResponseEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> signOut();

  Future<UserEntity> getProfile();
}
