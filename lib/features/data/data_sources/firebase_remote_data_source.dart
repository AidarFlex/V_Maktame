import 'package:vk_example/features/domain/entities/chat_entity.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  Stream<List<PostEntity>> getPosts();
  Future<void> getCreateCurrentUser(UserEntity userEntity);
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity userEntity);
  Future<void> signUp(UserEntity userEntity);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<void> createNewPost(PostEntity postEntity);
  Future<void> sendTextMessage(ChatEntity chatEntity, String channelId);
  Stream<List<ChatEntity>> getMessages(String channelId);
}
