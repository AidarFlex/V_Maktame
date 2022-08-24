import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required String postId,
    required String userId,
    required String userName,
    required Timestamp timestamp,
    required String imageURL,
    required String description,
  }) : super(
          postId: postId,
          userId: userId,
          userName: userName,
          timestamp: timestamp,
          imageURL: imageURL,
          description: description,
        );

  factory PostModel.fromJson(DocumentSnapshot snapshot) {
    return PostModel(
      postId: snapshot.get('id'),
      userId: snapshot.get('userID'),
      userName: snapshot.get('userName'),
      timestamp: snapshot.get('timestamp'),
      imageURL: snapshot.get('imageURL'),
      description: snapshot.get('description'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "id": postId,
      "userID": userId,
      "userName": userName,
      "timestamp": timestamp,
      "imageURL": imageURL,
      "description": description,
    };
  }
}
