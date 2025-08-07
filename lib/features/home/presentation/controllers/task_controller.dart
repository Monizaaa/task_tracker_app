import 'package:get/get.dart';
import 'package:task_tracker_app/core/errors/server_exception.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';

class TaskController extends GetxController {
  final isLoading = false.obs;
  final tasks = <TaskEntity>[].obs;
  final errorMessage = Rx<String?>(null);

  Future<void> searchTasks({String? keyword}) async {
    isLoading.value = true;
    errorMessage.value = null;

    // Mock data for demonstration
    final mockChats = [
      const TaskEntity(
        id: 1,
        projectName: 'Productivity Mobile App',
        taskName: 'Create Detail Booking',
        time: '2 min ago',
        status: 0.7,
      ),
      const TaskEntity(
        id: 2,
        projectName: 'Banking Mobile App',
        taskName: 'Revision Home Page',
        time: '8 min ago',
        status: 0.35,
      ),
      const TaskEntity(
        id: 3,
        projectName: 'Online Course',
        taskName: 'Working On Landing Page',
        time: '5 min ago',
        status: 0.2,
      ),
    ];

    mockChats.shuffle();

    try {
      await Future.delayed(const Duration(seconds: 1));
      tasks.assignAll(mockChats);
    } on ServerException catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }
}
