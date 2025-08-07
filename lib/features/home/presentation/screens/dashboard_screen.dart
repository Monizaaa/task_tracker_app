import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';
import 'package:task_tracker_app/core/widgets/custom_app_bar.dart';
import 'package:task_tracker_app/core/widgets/customer_loading.dart';
import 'package:task_tracker_app/features/home/presentation/controllers/task_controller.dart';
import 'package:task_tracker_app/features/home/presentation/widgets/project_color_card.dart';
import 'package:task_tracker_app/features/home/presentation/widgets/task_card.dart';
import 'package:task_tracker_app/features/project/presentation/controllers/project_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final _projectController = Get.find<ProjectController>();
  final _taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    _projectController.searchProjects();
    _taskController.searchTasks();
    final now = DateTime.now();
    // For more robust localization, consider using the `intl` package.
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final title = '${weekdays[now.weekday - 1]}, ${now.day}';

    List<Color> progressColors = [
      Color(0xFF4DB6AC), // Darker Teal
      Color(0xFFF06292), // Darker Pink
      Color(0xFFBA68C8), // Darker Purple
      Color(0xFF7986CB), // Darker Indigo
      Color(0xFF64B5F6), // Darker Blue
      Color(0xFFFFB300), // Darker Orange (more golden)
      Color(0xFF81C784), // Darker Green
      Color(0xFFFDD835), // Darker Yellow (more amber)
      Color(0xFFFF7043), // Darker Deep Orange
      Color(0xFF78909C), // Darker Blue Grey
    ];

    progressColors.shuffle();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            title: title,
            hideBackButton: true,
            actionButtonIcon: Icons.notifications_none_outlined,
            onActionButtonPressed: () {},
          ),
          const SizedBox(height: 30),
          Text(
            'Let’s make a \nhabits together 🙌',
            style: TextStyle(
              fontSize: 25,
              color:
                  Theme.of(context).extension<AppColorsExtension>()!.titleColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 150,
            child: Obx(() {
              if (_projectController.isLoading.value &&
                  _projectController.projects.isEmpty) {
                return const CustomerLoading();
              }

              if (_projectController.errorMessage.value != null) {
                return Center(
                  child: Text(_projectController.errorMessage.value!),
                );
              }

              if (_projectController.projects.isEmpty) {
                return const Center(child: Text('No projects found.'));
              }

              return CustomMaterialIndicator(
                onRefresh: () => _projectController.searchProjects(),
                indicatorBuilder: (context, controller) => CustomerLoading(),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _projectController.projects.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final progressColor =
                        progressColors[index % progressColors.length];
                    return SizedBox(
                      width: 285,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: ProjectColorCard(
                          project: _projectController.projects[index],
                          progressColor: progressColor,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'inProgress'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color:
                      Theme.of(
                        context,
                      ).extension<AppColorsExtension>()!.titleColor,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(Get.context!).primaryColor,
                size: 32,
              ),
            ],
          ),
          Expanded(
            child: Obx(() {
              if (_taskController.isLoading.value &&
                  _taskController.tasks.isEmpty) {
                return const CustomerLoading();
              }

              if (_taskController.errorMessage.value != null) {
                return Center(child: Text(_taskController.errorMessage.value!));
              }

              if (_taskController.tasks.isEmpty) {
                return const Center(child: Text('No chats found.'));
              }

              return CustomMaterialIndicator(
                onRefresh: () => _taskController.searchTasks(),
                indicatorBuilder: (context, controller) => CustomerLoading(),
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  itemCount: _taskController.tasks.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return TaskCard(
                      projectName: _taskController.tasks[index].projectName,
                      taskName: _taskController.tasks[index].taskName,
                      timeAgo: _taskController.tasks[index].time,
                      progress: _taskController.tasks[index].status,
                    );
                  },
                  separatorBuilder:
                      (context, index) =>
                          const Divider(color: Color(0xFFE9F1FF)),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
