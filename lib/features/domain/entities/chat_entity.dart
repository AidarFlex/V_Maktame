import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String userName;
  final String userId;
  final String message;
  final Timestamp timestamp;

  const ChatEntity({
    required this.userName,
    required this.userId,
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        userName,
        userId,
        message,
        timestamp,
      ];
}
