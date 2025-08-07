import 'package:get/get.dart';
import 'package:task_tracker_app/core/errors/server_exception.dart';
import 'package:task_tracker_app/features/chat/domain/entities/chat_entity.dart';

class ChatController extends GetxController {
  final isLoading = false.obs;
  final chats = <ChatEntity>[].obs;
  final errorMessage = Rx<String?>(null);

  Future<void> searchChats({String? keyword}) async {
    isLoading.value = true;
    errorMessage.value = null;

    // Mock data for demonstration
    final mockChats = [
      const ChatEntity(
        id: 1,
        displayName: 'Jenny Alxinder',
        avatar: 'assets/mocks/jeny.png',
        status: 'Active now',
      ),
      const ChatEntity(
        id: 2,
        displayName: 'Alex Avishek',
        avatar: 'assets/mocks/avishek.png',
        status: 'Active 1h ago',
      ),
      const ChatEntity(
        id: 3,
        displayName: 'Mehrin',
        avatar: 'assets/mocks/mehrin.png',
        status: 'Active 1h ago',
      ),
      const ChatEntity(
        id: 4,
        displayName: 'Jafor Dicrose',
        avatar: 'assets/mocks/jafor.png',
        status: 'Active 1h ago',
      ),
    ];

    mockChats.shuffle();

    try {
      await Future.delayed(const Duration(seconds: 1));
      chats.assignAll(mockChats);
    } on ServerException catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }
}
