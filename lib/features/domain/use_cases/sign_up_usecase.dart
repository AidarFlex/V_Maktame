import 'package:v_maktame/features/domain/entities/user_entity.dart';
import 'package:v_maktame/features/domain/repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signUp(user);
  }
}
