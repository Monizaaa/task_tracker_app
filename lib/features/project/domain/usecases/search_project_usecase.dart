import 'package:task_tracker_app/features/project/domain/entities/project_entity.dart';
import 'package:task_tracker_app/features/project/domain/repositories/project_repository.dart';

class SearchProjectUsecase {
  final ProjectRepository repository;

  SearchProjectUsecase(this.repository);

  Future<List<ProjectEntity>> call({String? keyword}) {
    return repository.searchProjects(keyword: keyword);
  }
}
