import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';
import 'package:task_tracker_app/core/widgets/custom_app_bar.dart';
import 'package:task_tracker_app/core/widgets/custom_button.dart';
import 'package:task_tracker_app/features/auth/presentation/controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              CustomAppBar(title: 'profile'.tr, hideBackButton: true),
              const SizedBox(height: 20),
              _buildProfileHeader(),
              const SizedBox(height: 32),
              _buildStatsSection(),
              const SizedBox(height: 32),
              _buildMenuListItem(title: 'My Projects', onTap: () {}),
              _buildMenuListItem(title: 'Join a Team', onTap: () {}),
              _buildMenuListItem(title: 'Settings', onTap: () {}),
              _buildMenuListItem(title: 'My Task', onTap: () {}),
              const SizedBox(height: 16),
              CustomButton(
                text: 'logout'.tr,
                onPressed: () {
                  Get.find<AuthController>().logout();
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the top section with the avatar, name, and edit button.
  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            _authController.user!.avatar ?? '',
          ), // Placeholder image
        ),
        const SizedBox(height: 30),
        Text(
          _authController.user!.displayName ?? '',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color:
                Theme.of(
                  Get.context!,
                ).extension<AppColorsExtension>()!.titleColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '@${_authController.user!.username ?? ''}',
          style: TextStyle(
            fontSize: 14,
            color:
                Theme.of(
                  Get.context!,
                ).extension<AppColorsExtension>()!.greyColor,
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(Get.context!).primaryColor,
            side: BorderSide(color: Theme.of(Get.context!).primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'edit'.tr,
            style: TextStyle(
              color:
                  Theme.of(
                    Get.context!,
                  ).extension<AppColorsExtension>()!.titleColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the stats row for "On Going" and "Total Complete".
  Widget _buildStatsSection() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(
            icon: Icons.timer_outlined,
            value: '5',
            label: 'On Going',
          ),
          const VerticalDivider(thickness: 1),
          _buildStatItem(
            icon: Icons.check_circle_outline,
            value: '25',
            label: 'Total Complete',
          ),
        ],
      ),
    );
  }

  /// Helper for a single stat item.
  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF002055)),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF002055),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }

  /// Builds a single menu list item card.
  Widget _buildMenuListItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFFE9F1FF), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color:
                    Theme.of(
                      Get.context!,
                    ).extension<AppColorsExtension>()!.titleColor,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color:
                  Theme.of(
                    Get.context!,
                  ).extension<AppColorsExtension>()!.titleColor,
              size: 36,
            ),
          ],
        ),
      ),
    );
  }
}
