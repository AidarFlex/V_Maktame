import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TextMessageEntity extends Equatable {
  final String message;
  final String senderID;
  final String userName;
  final Timestamp timeStamp;

  const TextMessageEntity(
      {required this.message,
      required this.senderID,
      required this.userName,
      required this.timeStamp});

  @override
  List<Object?> get props => [
        message,
        senderID,
        userName,
        timeStamp,
      ];
}
