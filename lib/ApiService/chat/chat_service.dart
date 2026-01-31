import 'dart:convert';
import 'package:era_shop/ApiModel/chat/ChatModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatApi extends GetxService {
  Future<ChatSendModel> sendMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    final url = Uri.parse(Constant.BASE_URL + Constant.chatSend);
    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode({
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
    });

    final response = await http.post(url, headers: headers, body: body).timeout(const Duration(seconds: 10));
    return ChatSendModel.fromJson(jsonDecode(response.body));
  }

  Future<ChatConversationModel> getConversations(String userId) async {
    final url = Uri.parse(Constant.BASE_URL + Constant.chatConversations).replace(queryParameters: {'userId': userId});
    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
    return ChatConversationModel.fromJson(jsonDecode(response.body));
  }

  Future<ChatMessagesModel> getMessages({
    required String userId,
    required String otherUserId,
  }) async {
    final url = Uri.parse(Constant.BASE_URL + Constant.chatMessages).replace(
      queryParameters: {'userId': userId, 'otherUserId': otherUserId},
    );
    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
    return ChatMessagesModel.fromJson(jsonDecode(response.body));
  }
}
