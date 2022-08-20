import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/features/domain/entities/user_entity.dart';
import 'package:vk_example/features/domain/use_cases/get_create_current_user.dart';
import 'package:vk_example/features/domain/use_cases/get_current_uid_usecase.dart';
import 'package:vk_example/features/domain/use_cases/sign_in_usecase.dart';
import 'package:vk_example/features/domain/use_cases/sign_up_usecase.dart';
import 'package:vk_example/features/presentation/cubit/credential/cretential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;
  CredentialCubit(
      {required this.signInUseCase,
      required this.signUpUseCase,
      required this.getCreateCurrentUserUseCase})
      : super(CredentialInitial());

  Future<void> signInSumbit({
    required String email,
    required String password,
  }) async {
    emit(CredentialLoading());
    try {
      await signInUseCase.call(UserEntity(
          email: email, password: password, userID: '', userName: ''));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpSumbit({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase.call(UserEntity(
          userID: '',
          userName: '',
          email: user.email,
          password: user.password));
      await getCreateCurrentUserUseCase.call(user);
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}