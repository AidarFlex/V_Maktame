import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/bloc/auth_cubit.dart';
import 'package:vk_example/page/auth_page.dart';
import 'package:vk_example/page/chat_page.dart';
import 'package:vk_example/page/create_post_page.dart';
import 'package:vk_example/page/home_page.dart';
import 'package:vk_example/page/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        home: AuthPage(),
        routes: {
          AuthPage.id: (context) => AuthPage(),
          RegisterPage.id: (context) => RegisterPage(),
          HomePage.id: (context) => HomePage(),
          CreatePostPage.id: (context) => CreatePostPage(),
          ChatPage.id: (context) => ChatPage(),
        },
      ),
    );
  }
}
