import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vk_example/features/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    userName,
    userID,
    // message,
    // timeStamp,
  }) : super(
          userName: userName,
          userID: userID,
          // message: message,
          // timeStamp: timeStamp,
        );

  factory ChatModel.fromJson(DocumentSnapshot snapshot) {
    return ChatModel(
      userName: snapshot.get('userName'),
      userID: snapshot.get('userID'),
      // message: snapshot.get('message'),
      // timeStamp: snapshot.get('timeStamp'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "userName": userName,
      "userID": userID,
      // "message": message,
      // "timeStamp": timeStamp,
    };
  }
}
