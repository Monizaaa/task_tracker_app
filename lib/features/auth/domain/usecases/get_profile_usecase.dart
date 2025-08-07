import 'package:task_tracker_app/features/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

class GetProfileUseCase {
  final AuthRepository _repository;

  GetProfileUseCase(this._repository);

  Future<UserEntity> call() async {
    return await _repository.getProfile();
  }
}
