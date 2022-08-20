import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vk_example/features/data/data_sources/firebase_remote_data_source.dart';
import 'package:vk_example/features/data/models/user_model.dart';
import 'package:vk_example/features/domain/entities/user_entity.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/domain/entities/chat_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  FirebaseRemoteDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseAuth});

  @override
  Future<void> createNewPost(PostEntity postEntity) {
    // TODO: implement createNewPost
    throw UnimplementedError();
  }

  @override
  Future<void> createPost(PostEntity postEntity) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity userEntity) async {
    final users = firebaseFirestore.collection('users');
    final uid = await getCurrentUId();
    users.doc(uid).get().then((user) {
      final newUser = UserModel(
              userID: userEntity.userID,
              userName: userEntity.userName,
              email: userEntity.email,
              password: userEntity.password)
          .toDocument();
      if (!user.exists) {
        users.doc(uid).set(newUser);
      } else {
        users.doc(uid).update(newUser);
      }
    }).catchError((error) {
      log('user already exist');
    });
  }

  @override
  Future<String> getCurrentUId() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<ChatEntity>> getMessages(String channelId) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Stream<List<PostEntity>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignIn() {
    // TODO: implement isSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> sendTextMessage(ChatEntity chatEntity) {
    // TODO: implement sendTextMessage
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(UserEntity userEntity) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: userEntity.email, password: userEntity.password);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> signUp(UserEntity userEntity) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: userEntity.email, password: userEntity.password);
  }
}
