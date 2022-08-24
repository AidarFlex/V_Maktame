import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String postId;
  final String userId;
  final String userName;
  final Timestamp timestamp;
  final String imageURL;
  final String description;

  const PostEntity({
    required this.postId,
    required this.userId,
    required this.userName,
    required this.timestamp,
    required this.imageURL,
    required this.description,
  });

  @override
  List<Object?> get props => [
        postId,
        userId,
        userName,
        timestamp,
        imageURL,
        description,
      ];
}
