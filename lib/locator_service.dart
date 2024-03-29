import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:v_maktame/features/data/data_sources/firebase_remote_data_source.dart';
import 'package:v_maktame/features/data/data_sources/firebase_remote_data_source_impl.dart';
import 'package:v_maktame/features/data/repositories/firebase_repository_impl.dart';
import 'package:v_maktame/features/domain/repositories/firebase_repository.dart';
import 'package:v_maktame/features/domain/use_cases/create_new_post_usecase.dart';
import 'package:v_maktame/features/domain/use_cases/get_create_current_user.dart';
import 'package:v_maktame/features/domain/use_cases/get_current_uid_usecase.dart';
import 'package:v_maktame/features/domain/use_cases/get_messages_usecases.dart';
import 'package:v_maktame/features/domain/use_cases/get_posts_usecase.dart';
import 'package:v_maktame/features/domain/use_cases/is_sign_in_usecase.dart';
import 'package:v_maktame/features/domain/use_cases/send_text_message_usecase.dart';
import 'package:v_maktame/features/domain/use_cases/sign_in_usecase.dart';
import 'package:v_maktame/features/domain/use_cases/sign_out_usecase.dart';
import 'package:v_maktame/features/domain/use_cases/sign_up_usecase.dart';
import 'package:v_maktame/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:v_maktame/features/presentation/cubit/chat/chat_cubit.dart';
import 'package:v_maktame/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:v_maktame/features/presentation/cubit/post/post_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        isSignInUseCase: sl.call(),
        signOutUseCase: sl.call(),
        getCurrentUidUseCase: sl.call(),
      ));
  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
        signInUseCase: sl.call(),
        signUpUseCase: sl.call(),
        getCreateCurrentUserUseCase: sl.call(),
      ));
  sl.registerFactory<PostCubit>(() => PostCubit(
        createNewPostUseCase: sl.call(),
        getPostsUseCase: sl.call(),
      ));
  sl.registerFactory<ChatCubit>(() => ChatCubit(
        sendTextMessageUseCase: sl.call(),
        getMessageUseCase: sl.call(),
      ));

  // UseCases
  sl.registerLazySingleton<CreateNewPostUseCase>(
      () => CreateNewPostUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetMessageUseCase>(
      () => GetMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetPostsUseCase>(
      () => GetPostsUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
      () => SendTextMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));

  // Repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  // Remote DataSource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          firebaseFirestore: sl.call(), firebaseAuth: sl.call()));

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseFirestore);
}
