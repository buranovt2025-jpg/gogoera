import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/ApiModel/chat/ChatModel.dart';
import 'package:era_shop/Controller/GetxController/chat/chat_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatController chatController = Get.put(ChatController());

  String? otherUserId;
  String otherUserName = "";
  String? otherUserImage;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      otherUserId = args["otherUserId"]?.toString();
      otherUserName = args["otherUserName"]?.toString() ?? "Пользователь";
      otherUserImage = args["otherUserImage"]?.toString();
    }
    if (otherUserId != null) {
      chatController.loadMessages(otherUserId!);
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (otherUserId == null || _textEditingController.text.trim().isEmpty) return;
    final text = _textEditingController.text.trim();
    _textEditingController.clear();
    chatController.sendMessage(text, otherUserId!);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            SizedBox(
              width: Get.width,
              height: double.maxFinite,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: PrimaryRoundButton(
                      onTaped: () => Get.back(),
                      icon: Icons.arrow_back_rounded,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GeneralTitle(title: otherUserName),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Stack(
              children: [
                Obx(() {
                  if (chatController.isLoading.value && chatController.messages.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ...chatController.messages.map((msg) => _buildMessageBubble(msg)),
                        SizedBox(height: Get.height / 10),
                      ],
                    ),
                  );
                }),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: isDark.value ? MyColors.blackBackground : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _textEditingController,
                            style: GoogleFonts.plusJakartaSans(color: isDark.value ? MyColors.white : MyColors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: isDark.value ? MyColors.lightBlack : MyColors.dullWhite,
                              hintText: "Сообщение...",
                              hintStyle: const TextStyle(color: Color(0xff9CA4AB), fontSize: 14),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onFieldSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _sendMessage(),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: MyColors.primaryPink,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.send, color: Colors.white, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    final isMe = msg.isFromMe(userId);
    final time = _formatTime(msg.createdAt);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: 16,
              backgroundColor: MyColors.lightGrey,
              backgroundImage: (otherUserImage != null && otherUserImage!.isNotEmpty)
                  ? CachedNetworkImageProvider(otherUserImage!)
                  : null,
              child: (otherUserImage == null || otherUserImage!.isEmpty)
                  ? Text(otherUserName.isNotEmpty ? otherUserName[0].toUpperCase() : "?", style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold))
                  : null,
            ),
          if (!isMe) const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isMe ? MyColors.primaryPink : const Color(0xffF6F6F6),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isMe ? 20 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 20),
                    ),
                  ),
                  child: Text(
                    msg.text ?? "",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: isMe ? Colors.white : Colors.grey.shade800,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          if (isMe) const SizedBox(width: 10),
          if (isMe)
            CircleAvatar(
              radius: 16,
              backgroundColor: MyColors.lightGrey,
              backgroundImage: editImage.isNotEmpty ? CachedNetworkImageProvider(editImage) : null,
              child: editImage.isEmpty ? Icon(Icons.person, size: 20, color: Colors.grey) : null,
            ),
        ],
      ),
    );
  }

  String _formatTime(dynamic createdAt) {
    if (createdAt == null) return "";
    try {
      final dt = createdAt is DateTime ? createdAt : DateTime.parse(createdAt.toString());
      return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return "";
    }
  }
}
