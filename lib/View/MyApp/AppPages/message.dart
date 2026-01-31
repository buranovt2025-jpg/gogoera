import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/ApiModel/chat/ChatModel.dart';
import 'package:era_shop/Controller/GetxController/chat/chat_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    if (userId.isNotEmpty) {
      chatController.loadConversations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  children: [
                    PrimaryRoundButton(onTaped: () => Get.back(), icon: Icons.arrow_back_rounded),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width / 4.7),
                      child: const GeneralTitle(title: "Сообщения"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (userId.isEmpty) {
                    return Center(
                      child: Text(
                        "Войдите, чтобы видеть чаты",
                        style: GoogleFonts.plusJakartaSans(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                  if (chatController.isLoading.value && chatController.conversations.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (chatController.conversations.isEmpty) {
                    return Center(
                      child: Text(
                        "Нет сообщений",
                        style: GoogleFonts.plusJakartaSans(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: chatController.conversations.length,
                    itemBuilder: (context, index) {
                      final conv = chatController.conversations[index];
                      return _buildConversationItem(conv);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConversationItem(ChatConversation conv) {
    final name = conv.user?.displayName ?? "Пользователь";
    final imageUrl = conv.user?.image;
    final lastMsg = conv.lastMessage ?? "";
    final time = _formatTime(conv.lastMessageAt);
    final unread = conv.unreadCount ?? 0;

    return InkWell(
      onTap: () => Get.toNamed("/ChatPage", arguments: {"otherUserId": conv.id, "otherUserName": name, "otherUserImage": imageUrl}),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: MyColors.lightGrey,
              backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                  ? CachedNetworkImageProvider(imageUrl)
                  : null,
              child: imageUrl == null || imageUrl.isEmpty
                  ? Text(name.isNotEmpty ? name[0].toUpperCase() : "?", style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.bold))
                  : null,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          time,
                          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lastMsg,
                            style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.grey.shade600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (unread > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: MyColors.primaryPink,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "$unread",
                              style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String? iso) {
    if (iso == null || iso.isEmpty) return "";
    try {
      final dt = DateTime.parse(iso);
      final now = DateTime.now();
      if (dt.day == now.day && dt.month == now.month && dt.year == now.year) {
        return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
      }
      return "${dt.day}.${dt.month}";
    } catch (_) {
      return "";
    }
  }
}
