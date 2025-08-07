import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';
import 'package:task_tracker_app/core/widgets/decorative_circles_widget.dart';
import 'package:task_tracker_app/features/auth/presentation/screens/profile_screen.dart';
import 'package:task_tracker_app/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:task_tracker_app/features/home/presentation/screens/dashboard_screen.dart';
import 'package:task_tracker_app/features/project/presentation/screens/project_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    DashboardScreen(),
    ProjectListScreen(),
    ChatListScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DecorativeCirclesWidget(height: Get.height, width: Get.width),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 82,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Left side icons
              _buildTabItem(icon: 'assets/icons/home_icon.svg', index: 0),
              _buildTabItem(icon: 'assets/icons/project_icon.svg', index: 1),

              _buildCircularButton(),

              // Right side icons
              _buildTabItem(icon: 'assets/icons/chat_icon.svg', index: 2),
              _buildTabItem(icon: 'assets/icons/profile_icon.svg', index: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({required String icon, required int index}) {
    return GestureDetector(
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          _selectedIndex == index
              ? Theme.of(context).primaryColor
              : Theme.of(context).extension<AppColorsExtension>()!.greyColor ??
                  Colors.grey,
          BlendMode.srcIn,
        ),
      ),
      onTap: () => _onItemTapped(index),
    );
  }

  Widget _buildCircularButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,

          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.25,
              ), // Black with 25% opacity
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4), // y-offset of 4
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
