import 'package:v_maktame/features/domain/repositories/firebase_repository.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository repository;

  GetCurrentUidUseCase({required this.repository});
  Future<String> call() async {
    return await repository.getCurrentUId();
  }
}
