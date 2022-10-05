import 'package:v_maktame/features/domain/entities/post_entity.dart';
import 'package:v_maktame/features/domain/repositories/firebase_repository.dart';

class CreateNewPostUseCase {
  final FirebaseRepository repository;

  CreateNewPostUseCase({required this.repository});

  Future<void> call(PostEntity postEntity) async {
    return repository.createNewPost(postEntity);
  }
}
