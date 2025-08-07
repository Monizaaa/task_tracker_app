import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class CreateUserUseCase {
  final AuthRepository _repository;

  CreateUserUseCase(this._repository);

  Future<UserEntity> call({
    required String email,
    required String password,
    required String displayName,
  }) async {
    return await _repository.createUserWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
