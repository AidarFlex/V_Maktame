import 'package:v_maktame/features/domain/entities/text_message_entity.dart';
import 'package:v_maktame/features/domain/repositories/firebase_repository.dart';

class GetMessageUseCase {
  final FirebaseRepository repository;

  GetMessageUseCase({required this.repository});

  Stream<List<TextMessageEntity>> call(String channelId) {
    return repository.getMessages(channelId);
  }
}
