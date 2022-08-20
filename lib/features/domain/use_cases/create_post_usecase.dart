import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/domain/repositories/firebase_repository.dart';

class CreatePostUseCase {
  final FirebaseRepository repository;

  CreatePostUseCase({required this.repository});

  Future<void> call(PostEntity groupEntity) async {
    return await repository.createPost(groupEntity);
  }
}
