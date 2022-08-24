import 'package:vk_example/features/domain/entities/chat_entity.dart';
import 'package:vk_example/features/domain/repositories/firebase_repository.dart';

class SendTextMessageUseCase {
  final FirebaseRepository repository;

  SendTextMessageUseCase({required this.repository});

  Future<void> call(ChatEntity chatEntity, String channelId) async {
    return await repository.sendTextMessage(chatEntity, channelId);
  }
}
