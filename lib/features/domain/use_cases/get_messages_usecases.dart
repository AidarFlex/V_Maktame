import 'package:vk_example/features/domain/entities/chat_entity.dart';
import 'package:vk_example/features/domain/repositories/firebase_repository.dart';

class GetMessageUseCase {
  final FirebaseRepository repository;

  GetMessageUseCase({required this.repository});

  Stream<List<ChatEntity>> call(String channelId) {
    return repository.getMessages(channelId);
  }
}
