import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    postID,
    userID,
    userName,
    timestamp,
    imageUrl,
    description,
  }) : super(
            postID: postID,
            userID: userID,
            userName: userName,
            timestamp: timestamp,
            imageUrl: imageUrl,
            description: description);

  factory PostModel.fromJson(DocumentSnapshot snapshot) {
    return PostModel(
      postID: snapshot.get('postID'),
      userID: snapshot.get('userID'),
      userName: snapshot.get('userName'),
      timestamp: snapshot.get('timestamp'),
      imageUrl: snapshot.get('imageUrl'),
      description: snapshot.get('description'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "postID": postID,
      "userID": userID,
      "userName": userName,
      "timestamp": timestamp,
      "imageUrl": imageUrl,
      "description": description,
    };
  }
}
