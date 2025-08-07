import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:task_tracker_app/core/widgets/custom_app_bar.dart';
import 'package:task_tracker_app/core/widgets/custom_input_field.dart';
import 'package:task_tracker_app/core/widgets/custom_outline_button.dart';
import 'package:task_tracker_app/core/widgets/customer_loading.dart';
import 'package:task_tracker_app/features/project/presentation/controllers/project_controller.dart';
import 'package:task_tracker_app/features/project/presentation/widgets/project_card.dart';

class ProjectListScreen extends StatelessWidget {
  ProjectListScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  final ProjectController controller = Get.find<ProjectController>();

  // A list of soft, pleasant colors for the project cards
  final List<Color> _progressColors = const [
    Color(0xFF80CBC4), // Teal 200
    Color(0xFFF48FB1), // Pink 200
    Color(0xFFCE93D8), // Purple 200
    Color(0xFF9FA8DA), // Indigo 200
    Color(0xFF90CAF9), // Blue 200
    Color(0xFF81D4FA), // Light Blue 200
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          CustomAppBar(
            title: 'Projects',
            hideBackButton: true,
            actionButtonIcon: Icons.add_rounded,
            onActionButtonPressed: () {},
          ),
          const SizedBox(height: 40),
          CustomInputField(
            controller: _searchController,
            hintText: 'search'.tr,
            prefixIcon: 'assets/icons/search_icon.svg',
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomOutlineButton(
                    text: 'Favourites',
                    active: true,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16),
                  CustomOutlineButton(
                    text: 'Recents',
                    active: false,
                    onPressed: () {},
                  ),
                  CustomOutlineButton(
                    text: 'All',
                    active: false,
                    onPressed: () {},
                  ),
                ],
              ),
              SvgPicture.asset('assets/icons/menu_icon.svg'),
            ],
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.projects.isEmpty) {
                return const CustomerLoading();
              }

              if (controller.errorMessage.value != null) {
                return Center(child: Text(controller.errorMessage.value!));
              }

              if (controller.projects.isEmpty) {
                return const Center(child: Text('No projects found.'));
              }

              return CustomMaterialIndicator(
                onRefresh: () => controller.searchProjects(),
                indicatorBuilder: (context, controller) => CustomerLoading(),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 24, bottom: 16),
                  itemCount: controller.projects.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final progressColor =
                        _progressColors[index % _progressColors.length];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ProjectCard(
                        project: controller.projects[index],
                        progressColor: progressColor,
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
