import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vk_example/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    userName,
    email,
    password,
  }) : super(
          userName: userName,
          email: email,
          password: password,
        );

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
      userName: snapshot.get('userName'),
      email: snapshot.get('email'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "userName": userName,
      "email": email,
    };
  }
}
