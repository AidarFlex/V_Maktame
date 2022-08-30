import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vk_example/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    userID,
    userName,
    email,
    password,
  }) : super(
          userID: userID,
          userName: userName,
          email: email,
          password: password,
        );

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
      userID: snapshot.get('userID'),
      userName: snapshot.get('userName'),
      email: snapshot.get('email'),
      password: snapshot.get('password'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "userID": userID,
      "userName": userName,
      "email": email,
      "password": password,
    };
  }
}
