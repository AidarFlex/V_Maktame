import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/features/domain/use_cases/get_current_uid_usecase.dart';
import 'package:vk_example/features/domain/use_cases/is_sign_in_usecase.dart';
import 'package:vk_example/features/domain/use_cases/sign_out_usecase.dart';
import 'package:vk_example/features/presentation/cubit/auth/auth_cubit.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;

  AuthCubit(
      {required this.isSignInUseCase,
      required this.signOutUseCase,
      required this.getCurrentUidUseCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      bool isSignIn = await isSignInUseCase.call();
      log(isSignIn.toString());
      if (isSignIn == true) {
        final uid = await getCurrentUidUseCase.call();

        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase.call();
      log('user id $uid');
      emit(Authenticated(uid: uid));
    } catch (_) {
      log('user id is null');
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
