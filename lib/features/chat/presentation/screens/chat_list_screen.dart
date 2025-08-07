import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker_app/core/widgets/custom_app_bar.dart';
import 'package:task_tracker_app/core/widgets/custom_input_field.dart';
import 'package:task_tracker_app/core/widgets/customer_loading.dart';
import 'package:task_tracker_app/features/chat/presentation/controllers/chat_controller.dart';
import 'package:task_tracker_app/features/chat/presentation/widgets/chat_card.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  final ChatController _controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          CustomAppBar(
            title: 'Chats',
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
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value && _controller.chats.isEmpty) {
                return const CustomerLoading();
              }

              if (_controller.errorMessage.value != null) {
                return Center(child: Text(_controller.errorMessage.value!));
              }

              if (_controller.chats.isEmpty) {
                return const Center(child: Text('No chats found.'));
              }

              return CustomMaterialIndicator(
                onRefresh: () => _controller.searchChats(),
                indicatorBuilder: (context, controller) => CustomerLoading(),
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  itemCount: _controller.chats.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return ChatCard(chat: _controller.chats[index]);
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
