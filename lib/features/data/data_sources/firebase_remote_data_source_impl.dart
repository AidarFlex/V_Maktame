import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vk_example/features/data/data_sources/firebase_remote_data_source.dart';
import 'package:vk_example/features/data/models/chat_model.dart';
import 'package:vk_example/features/data/models/post_model.dart';
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
  Future<void> createNewPost(PostEntity postEntity) async {
    try {
      await firebaseFirestore.collection('posts').doc(postEntity.postID).set(
          PostModel(
            postID: postEntity.postID,
            userID: postEntity.userID,
            userName: postEntity.userName,
            timestamp: postEntity.timestamp,
            imageUrl: postEntity.imageUrl,
            description: postEntity.description,
          ).toDocument(),
          SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity userEntity) async {
    try {
      final users = firebaseFirestore.collection('users');
      final uid = await getCurrentUId();
      users.doc(uid).get().then((user) {
        final newUser = UserModel(
          userName: userEntity.userName,
          email: userEntity.email,
          password: userEntity.password,
        ).toDocument();
        if (!user.exists) {
          users.doc(uid).set(newUser);
        } else {
          users.doc(uid).update(newUser);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> getCurrentUId() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<ChatEntity>> getMessages(String channelId) {
    return firebaseFirestore
        .collection('posts')
        .doc(channelId)
        .collection('chat')
        .orderBy('timestamp')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((snapshot) => ChatModel.fromJson(snapshot))
            .toList());
  }

  @override
  Stream<List<PostEntity>> getPosts() {
    return firebaseFirestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((snapshot) => PostModel.fromJson(snapshot))
            .toList());
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> sendTextMessage(ChatEntity chatEntity, String channelId) async {
    try {
      final messageRef = firebaseFirestore
          .collection('posts')
          .doc(channelId)
          .collection('chat');
      final messageId = messageRef.doc().id;
      await messageRef.doc(messageId).set(ChatModel(
            userName: chatEntity.userName,
            userId: chatEntity.userId,
            message: chatEntity.message,
            timestamp: chatEntity.timestamp,
          ).toDocument());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signIn(UserEntity userEntity) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: userEntity.email, password: userEntity.password);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signUp(UserEntity userEntity) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: userEntity.email, password: userEntity.password);
      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': userEntity.email,
        'userName': userEntity.userName,
        'userID': userCredential.user!.uid
      });
      userCredential.user!.updateDisplayName(userEntity.userName);
    } catch (e) {
      print(e);
    }
  }
}
