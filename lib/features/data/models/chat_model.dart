import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vk_example/features/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required String userName,
    required String userID,
    required String message,
    required Timestamp timestamp,
  }) : super(
          userName: userName,
          userID: userID,
          message: message,
          timestamp: timestamp,
        );

  factory ChatModel.fromJson(DocumentSnapshot snapshot) {
    return ChatModel(
      userName: snapshot.get('userName'),
      userID: snapshot.get('userID'),
      message: snapshot.get('message'),
      timestamp: snapshot.get('timestamp'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "userID": userID,
      "message": message,
      "timestamp": timestamp,
    };
  }
}
