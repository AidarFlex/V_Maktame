import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String postID;
  final String userID;
  final String userName;
  final Timestamp timestamp;
  final String imageUrl;
  final String description;

  const PostEntity({
    required this.postID,
    required this.userID,
    required this.userName,
    required this.timestamp,
    required this.imageUrl,
    required this.description,
  });

  @override
  List<Object?> get props => [
        postID,
        userID,
        userName,
        timestamp,
        imageUrl,
        description,
      ];
}
