class ChatConversationModel {
  bool? status;
  String? message;
  List<ChatConversation>? data;

  ChatConversationModel({this.status, this.message, this.data});

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) => ChatConversationModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : (json["data"] as List).map((e) => ChatConversation.fromJson(e)).toList(),
      );
}

class ChatConversation {
  String? id;
  String? lastMessage;
  String? lastMessageAt;
  int? unreadCount;
  ChatUser? user;

  ChatConversation({this.id, this.lastMessage, this.lastMessageAt, this.unreadCount, this.user});

  factory ChatConversation.fromJson(Map<String, dynamic> json) => ChatConversation(
        id: json["_id"],
        lastMessage: json["lastMessage"],
        lastMessageAt: json["lastMessageAt"],
        unreadCount: json["unreadCount"] ?? 0,
        user: json["user"] == null ? null : ChatUser.fromJson(json["user"]),
      );
}

class ChatUser {
  String? id;
  String? firstName;
  String? lastName;
  String? image;

  ChatUser({this.id, this.firstName, this.lastName, this.image});

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        image: json["image"],
      );

  String get displayName => "$firstName $lastName".trim();
}

class ChatMessagesModel {
  bool? status;
  String? message;
  List<ChatMessage>? data;

  ChatMessagesModel({this.status, this.message, this.data});

  factory ChatMessagesModel.fromJson(Map<String, dynamic> json) => ChatMessagesModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : (json["data"] as List).map((e) => ChatMessage.fromJson(e)).toList(),
      );
}

class ChatMessage {
  String? id;
  String? senderId;
  String? receiverId;
  String? text;
  bool? read;
  String? createdAt;
  ChatUser? sender;
  ChatUser? receiver;

  ChatMessage({this.id, this.senderId, this.receiverId, this.text, this.read, this.createdAt, this.sender, this.receiver});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    dynamic senderData = json["senderId"];
    dynamic receiverData = json["receiverId"];
    return ChatMessage(
      id: json["_id"],
      senderId: senderData is String ? senderData : senderData?["_id"],
      receiverId: receiverData is String ? receiverData : receiverData?["_id"],
      text: json["text"],
      read: json["read"],
      createdAt: json["createdAt"],
      sender: senderData is Map ? ChatUser.fromJson(senderData) : null,
      receiver: receiverData is Map ? ChatUser.fromJson(receiverData) : null,
    );
  }

  bool isFromMe(String myUserId) => senderId == myUserId;
}

class ChatSendModel {
  bool? status;
  String? message;
  ChatMessage? data;

  ChatSendModel({this.status, this.message, this.data});

  factory ChatSendModel.fromJson(Map<String, dynamic> json) => ChatSendModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ChatMessage.fromJson(json["data"]),
      );
}
