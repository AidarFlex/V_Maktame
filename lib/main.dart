import 'package:flutter/material.dart';
import 'package:vk_example/page/auth_page.dart';
import 'package:vk_example/page/home_page.dart';
import 'package:vk_example/page/register_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/auth': (context) => AuthPage(),
        '/home_page': (context) => HomePage(),
        '/register_page': (context) => RegisterPage(),
      },
      initialRoute: '/auth',
    );
  }
}
