import 'package:task_tracker_app/features/project/domain/entities/project_entity.dart';

abstract class ProjectRepository {
  Future<List<ProjectEntity>> searchProjects({String? keyword});
}
