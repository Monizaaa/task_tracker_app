import 'package:task_tracker_app/core/errors/server_exception.dart';
import 'package:task_tracker_app/features/project/data/datasources/project_remote_datasource.dart';
import 'package:task_tracker_app/features/project/domain/entities/project_entity.dart';
import 'package:task_tracker_app/features/project/domain/repositories/project_repository.dart';

/// AuthRepositoryImpl is the concrete implementation of the AuthRepository contract.
/// It coordinates data from the remote data source and handles exceptions.
class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;

  ProjectRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProjectEntity>> searchProjects({String? keyword}) async {
    try {
      final results = await remoteDataSource.searchProjects(keyword: keyword);
      return results;
    } on ServerException {
      rethrow;
    }
  }
}
