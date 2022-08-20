import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/domain/repositories/firebase_repository.dart';

class CreateNewPostUseCase {
  final FirebaseRepository repository;

  CreateNewPostUseCase({required this.repository});

  Future<void> call(PostEntity postEntity) async {
    return repository.createNewPost(postEntity);
  }
}
