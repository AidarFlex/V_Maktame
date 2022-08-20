import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;
  final String userID;
  final String userName;
  final Timestamp timestamp;
  final String imageURL;
  final String description;

  const PostEntity({
    required this.id,
    required this.userID,
    required this.userName,
    required this.timestamp,
    required this.imageURL,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        userID,
        userName,
        timestamp,
        imageURL,
        description,
      ];
}
