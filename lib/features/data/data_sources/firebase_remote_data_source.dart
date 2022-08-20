import 'package:vk_example/features/domain/entities/chat_entity.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> getCreateCurrentUser(UserEntity userEntity);
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity userEntity);
  Future<void> signUp(UserEntity userEntity);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<void> createPost(PostEntity postEntity);
  Stream<List<PostEntity>> getPosts();
  Future<void> createNewPost(PostEntity postEntity);
  Future<void> sendTextMessage(ChatEntity chatEntity);
  Stream<List<ChatEntity>> getMessages(String channelId);
}
