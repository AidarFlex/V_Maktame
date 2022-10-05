import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_maktame/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:v_maktame/features/presentation/cubit/auth/auth_state.dart';
import 'package:v_maktame/features/presentation/cubit/chat/chat_cubit.dart';
import 'package:v_maktame/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:v_maktame/features/presentation/cubit/post/post_cubit.dart';
import 'package:v_maktame/features/presentation/pages/auth_page.dart';
import 'package:v_maktame/features/presentation/pages/create_post_page.dart';
import 'package:v_maktame/features/presentation/pages/home_page.dart';
import 'package:v_maktame/features/presentation/pages/register_page.dart';
import 'package:v_maktame/firebase_options.dart';
import 'package:v_maktame/locator_service.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<CredentialCubit>(
          create: (_) => di.sl<CredentialCubit>(),
        ),
        BlocProvider<PostCubit>(
          create: (_) => di.sl<PostCubit>()..getPosts(),
        ),
        BlocProvider<ChatCubit>(
          create: (_) => di.sl<ChatCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'V MISIS',
        initialRoute: '/',
        routes: {
          '/': (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return const HomePage();
                } else {
                  return const AuthPage();
                }
              },
            );
          },
          // '/home_page': (context) => const HomePage(),
          '/register_page': (context) => const RegisterPage(),
          '/create_post_page': (context) => const CreatePostPage(),
        },
      ),
    );
  }
}
