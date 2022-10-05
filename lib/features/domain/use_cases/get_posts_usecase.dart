import 'package:v_maktame/features/domain/entities/post_entity.dart';
import 'package:v_maktame/features/domain/repositories/firebase_repository.dart';

class GetPostsUseCase {
  final FirebaseRepository repository;

  GetPostsUseCase({required this.repository});

  Stream<List<PostEntity>> call() {
    return repository.getPosts();
  }
}
