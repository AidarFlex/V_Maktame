import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required String id,
    required String userID,
    required String userName,
    required Timestamp timestamp,
    required String imageURL,
    required String description,
  }) : super(
          id: id,
          userID: userID,
          userName: userName,
          timestamp: timestamp,
          imageURL: imageURL,
          description: description,
        );

  factory PostModel.fromJson(DocumentSnapshot snapshot) {
    return PostModel(
      id: snapshot.get('id'),
      userID: snapshot.get('userID'),
      userName: snapshot.get('userName'),
      timestamp: snapshot.get('timestamp'),
      imageURL: snapshot.get('imageURL'),
      description: snapshot.get('description'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userID": userID,
      "userName": userName,
      "timestamp": timestamp,
      "imageURL": imageURL,
      "description": description,
    };
  }
}
