import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vk_example/features/domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  const TextMessageModel(
      {required String message,
      required String senderID,
      required String userName,
      required Timestamp timeStamp})
      : super(
            message: message,
            senderID: senderID,
            userName: userName,
            timeStamp: timeStamp);

  factory TextMessageModel.fromJson(DocumentSnapshot snapshot) {
    return TextMessageModel(
        message: snapshot.get('message'),
        senderID: snapshot.get('senderID'),
        userName: snapshot.get('userName'),
        timeStamp: snapshot.get('timeStamp'));
  }

  Map<String, dynamic> toDocument() {
    return {
      'message': message,
      'senderID': senderID,
      'userName': userName,
      'timeStamp': timeStamp,
    };
  }
}
