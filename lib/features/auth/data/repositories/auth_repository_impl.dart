import 'package:task_tracker_app/core/errors/server_exception.dart';
import 'package:task_tracker_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:task_tracker_app/features/auth/domain/entities/signin_response_entity.dart';
import 'package:task_tracker_app/features/auth/domain/entities/user_entity.dart';
import 'package:task_tracker_app/features/auth/domain/repositories/auth_repository.dart';

/// AuthRepositoryImpl is the concrete implementation of the AuthRepository contract.
/// It coordinates data from the remote data source and handles exceptions.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final userModel = await remoteDataSource.createUserWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
      return userModel; // UserModel is a subtype of UserEntity, so this is valid.
    } on ServerException {
      // In a real app, you would catch the exception and return a Failure object.
      rethrow;
    }
  }

  @override
  Future<SigninResponseEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    // This would typically involve clearing a local token and could also
    // call a logout endpoint on the server.
    return;
  }

  @override
  Future<UserEntity> getProfile() async {
    try {
      return await remoteDataSource.getProfile();
    } on ServerException {
      rethrow;
    }
  }
}
