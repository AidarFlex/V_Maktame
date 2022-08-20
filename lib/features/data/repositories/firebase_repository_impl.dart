import 'package:vk_example/features/data/data_sources/firebase_remote_data_source.dart';
import 'package:vk_example/features/domain/entities/user_entity.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/domain/entities/chat_entity.dart';
import 'package:vk_example/features/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});
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
  Future<void> getCreateCurrentUser(UserEntity userEntity) async =>
      remoteDataSource.getCreateCurrentUser(userEntity);

  @override
  Future<String> getCurrentUId() async =>
      await remoteDataSource.getCurrentUId();

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
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> sendTextMessage(ChatEntity chatEntity) {
    // TODO: implement sendTextMessage
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(UserEntity userEntity) async =>
      remoteDataSource.signIn(userEntity);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity userEntity) async =>
      remoteDataSource.signUp(userEntity);
}
