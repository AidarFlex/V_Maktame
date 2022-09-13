import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:vk_example/features/domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  TextMessageModel(
      {required String message,
      required String userID,
      required String userName,
      required Timestamp timeStamp})
      : super(
            message: message,
            userID: userID,
            userName: userName,
            timeStamp: timeStamp);

  factory TextMessageModel.fromJson(DocumentSnapshot snapshot) {
    return TextMessageModel(
        message: snapshot.get('message'),
        userID: snapshot.get('userID'),
        userName: snapshot.get('userName'),
        timeStamp: snapshot.get('timeStamp'));
  }

  Map<String, dynamic> toDocument() {
    return {
      'message': message,
      'userID': userID,
      'userName': userName,
      'timeStamp': timeStamp,
    };
  }
}
