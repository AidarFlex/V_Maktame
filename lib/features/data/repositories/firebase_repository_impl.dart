import 'package:v_maktame/features/data/data_sources/firebase_remote_data_source.dart';
import 'package:v_maktame/features/domain/entities/post_entity.dart';
import 'package:v_maktame/features/domain/entities/text_message_entity.dart';
import 'package:v_maktame/features/domain/entities/user_entity.dart';
import 'package:v_maktame/features/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> createNewPost(PostEntity postEntity) async =>
      await remoteDataSource.createNewPost(postEntity);

  @override
  Future<void> getCreateCurrentUser(UserEntity userEntity) async =>
      remoteDataSource.getCreateCurrentUser(userEntity);

  @override
  Future<String> getCurrentUId() async =>
      await remoteDataSource.getCurrentUId();

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) =>
      remoteDataSource.getMessages(channelId);

  @override
  Stream<List<PostEntity>> getPosts() => remoteDataSource.getPosts();

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> sendTextMessage(
          TextMessageEntity textMessageEntity, String channelId) async =>
      await remoteDataSource.sendTextMessage(textMessageEntity, channelId);

  @override
  Future<void> signIn(UserEntity userEntity) async =>
      remoteDataSource.signIn(userEntity);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity userEntity) async =>
      remoteDataSource.signUp(userEntity);
}
