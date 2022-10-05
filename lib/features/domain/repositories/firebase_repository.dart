import 'package:v_maktame/features/domain/entities/post_entity.dart';
import 'package:v_maktame/features/domain/entities/text_message_entity.dart';
import 'package:v_maktame/features/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  Stream<List<PostEntity>> getPosts();
  Future<void> getCreateCurrentUser(UserEntity userEntity);
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity userEntity);
  Future<void> signUp(UserEntity userEntity);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<void> createNewPost(PostEntity postEntity);
  Future<void> sendTextMessage(
      TextMessageEntity textMessageEntity, String channelId);
  Stream<List<TextMessageEntity>> getMessages(String channelId);
}
