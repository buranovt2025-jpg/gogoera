import 'package:era_shop/ApiModel/chat/ChatModel.dart';
import 'package:era_shop/ApiService/chat/chat_service.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final ChatApi _chatApi = ChatApi();

  RxBool isLoading = false.obs;
  RxBool isSending = false.obs;
  List<ChatConversation> conversations = [];
  List<ChatMessage> messages = [];
  ChatUser? otherUser;

  Future<void> loadConversations() async {
    if (userId.isEmpty) return;
    isLoading.value = true;
    try {
      final res = await _chatApi.getConversations(userId);
      if (res.status == true && res.data != null) {
        conversations = res.data!;
      }
    } catch (e) {
      displayToast(message: "Failed to load conversations");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> loadMessages(String otherUserId) async {
    if (userId.isEmpty) return;
    isLoading.value = true;
    try {
      final res = await _chatApi.getMessages(userId: userId, otherUserId: otherUserId);
      if (res.status == true && res.data != null) {
        messages = res.data!;
      }
    } catch (e) {
      displayToast(message: "Failed to load messages");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> sendMessage(String text, String receiverId) async {
    if (userId.isEmpty || text.trim().isEmpty) return;
    isSending.value = true;
    try {
      final res = await _chatApi.sendMessage(senderId: userId, receiverId: receiverId, text: text.trim());
      if (res.status == true && res.data != null) {
        messages.add(res.data!);
        update();
      } else {
        displayToast(message: res.message ?? "Failed to send");
      }
    } catch (e) {
      displayToast(message: "Failed to send message");
    } finally {
      isSending.value = false;
      update();
    }
  }

  void openChat(ChatConversation conv) {
    otherUser = conv.user;
    if (conv.id != null) {
      loadMessages(conv.id!);
    }
  }
}
