import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String userName;
  final String userID;
  // final String message;
  // final Timestamp timeStamp;

  const ChatEntity({
    required this.userName,
    required this.userID,
    // required this.message,
    // required this.timeStamp,
  });

  @override
  List<Object?> get props => [
        userName,
        userID,
        // message,
        // timeStamp,
      ];
}
