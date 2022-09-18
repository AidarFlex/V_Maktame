import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vk_example/features/data/data_sources/firebase_remote_data_source.dart';
import 'package:vk_example/features/data/models/post_model.dart';
import 'package:vk_example/features/data/models/text_message_model.dart';
import 'package:vk_example/features/data/models/user_model.dart';
import 'package:vk_example/features/domain/entities/text_message_entity.dart';
import 'package:vk_example/features/domain/entities/user_entity.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  FirebaseRemoteDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseAuth});

  @override
  Future<void> createNewPost(PostEntity postEntity) async {
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
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity userEntity) async {
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
  }

  @override
  Future<String> getCurrentUId() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    return firebaseFirestore
        .collection('posts')
        .doc(channelId)
        .collection('chat')
        .orderBy('timeStamp')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((snapshot) => TextMessageModel.fromJson(snapshot))
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
  Future<void> sendTextMessage(
      TextMessageEntity textMessageEntity, String channelId) async {
    final messageRef =
        firebaseFirestore.collection('posts').doc(channelId).collection('chat');
    final messageId = messageRef.doc().id;
    await messageRef.doc(messageId).set(TextMessageModel(
            message: textMessageEntity.message,
            timeStamp: textMessageEntity.timeStamp,
            senderID: textMessageEntity.senderID,
            userName: textMessageEntity.userName)
        .toDocument());
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
  }
}
