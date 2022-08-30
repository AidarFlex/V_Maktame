import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vk_example/features/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    userName,
    userId,
    message,
    timestamp,
  }) : super(
          userName: userName,
          userId: userId,
          message: message,
          timestamp: timestamp,
        );

  factory ChatModel.fromJson(DocumentSnapshot snapshot) {
    return ChatModel(
      userName: snapshot.get('userName'),
      userId: snapshot.get('userID'),
      message: snapshot.get('message'),
      timestamp: snapshot.get('timestamp'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "userName": userName,
      "userID": userId,
      "message": message,
      "timestamp": timestamp,
    };
  }
}
