import 'package:get/get.dart';
import 'package:task_tracker_app/core/errors/server_exception.dart';
import 'package:task_tracker_app/features/project/domain/entities/project_entity.dart';
import 'package:task_tracker_app/features/project/domain/usecases/search_project_usecase.dart';

class ProjectController extends GetxController {
  final SearchProjectUsecase _searchProjectUsecase;

  ProjectController({required SearchProjectUsecase searchProjectUsecase})
    : _searchProjectUsecase = searchProjectUsecase;

  final isLoading = false.obs;
  final projects = <ProjectEntity>[].obs;
  final errorMessage = Rx<String?>(null);

  Future<void> searchProjects({String? keyword}) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await Future.delayed(Duration(seconds: 1));
      final result = await _searchProjectUsecase(keyword: keyword);
      result.shuffle();
      projects.assignAll(result);
    } on ServerException catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }
}
