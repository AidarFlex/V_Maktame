import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/domain/repositories/firebase_repository.dart';

class GetPostsUseCase {
  final FirebaseRepository repository;

  GetPostsUseCase({required this.repository});

  Stream<List<PostEntity>> call() {
    return repository.getPosts();
  }
}
