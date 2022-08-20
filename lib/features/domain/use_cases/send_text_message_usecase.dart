import 'package:vk_example/features/domain/entities/chat_entity.dart';
import 'package:vk_example/features/domain/repositories/firebase_repository.dart';

class SendTextMessageUseCase {
  final FirebaseRepository repository;

  SendTextMessageUseCase({required this.repository});

  Future<void> call(ChatEntity textMessageEntity) async {
    return await repository.sendTextMessage(textMessageEntity);
  }
}
