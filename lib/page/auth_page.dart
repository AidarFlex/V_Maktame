import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vk_example/model/theme.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.colorTheme,
      appBar: AppBar(
        backgroundColor: ColorTheme.appBarColor,
        elevation: 0,
        title: const Text(
          'ВКОНТАКТЕ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const _FormAuth(),
    );
  }
}

class _FormAuth extends StatelessWidget {
  const _FormAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final circulareShape = MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _InstallApp(),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            color: ColorTheme.appBarColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Мобильная версия поможет вам оставаться ВКонтакте, даже если вы далеко от компьютера.',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 15),
                  _AuthWidget(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Українська  English  all languages »',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: ColorTheme.thirdColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Версия для компьютера',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: ColorTheme.thirdColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Приложение для iOS',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: ColorTheme.thirdColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InstallApp extends StatelessWidget {
  const _InstallApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ColorTheme.appBarColor),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero))),
        onPressed: () {},
        child: Row(
          children: const [
            Icon(
              Icons.phone_iphone,
              color: ColorTheme.secondTextColor,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Установить приложение ВКонтакте',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: ColorTheme.firstTextColor),
              ),
            ),
            Icon(Icons.navigate_next, color: ColorTheme.secondTextColor),
          ],
        ),
      ),
    );
  }
}

class _AuthWidget extends StatefulWidget {
  const _AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<_AuthWidget> {
  void _auth() {
    Navigator.of(context).pushNamed('/home_page');
    setState(() {});
  }

  void _register() {
    Navigator.of(context).pushNamed('/register_page');
    setState(() {});
  }

  final circulareShape = MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Телефон или email',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Пароль',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _auth,
                child: const Text('Войти'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorTheme.buttonColor),
                  foregroundColor:
                      MaterialStateProperty.all(ColorTheme.appBarColor),
                  shape: circulareShape,
                ),
              )),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Забыли пароль?',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ColorTheme.appBarColor),
                foregroundColor:
                    MaterialStateProperty.all(ColorTheme.firstTextColor),
                shape: circulareShape,
              ),
            ),
          ),
          const SizedBox(height: 60),
          const Text(
            'Впервые ВКонтакте?',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: ColorTheme.thirdColor),
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _register,
                child: const Text('Зарегистрироваться'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorTheme.registerColor),
                  foregroundColor:
                      MaterialStateProperty.all(ColorTheme.appBarColor),
                  shape: circulareShape,
                ),
              )),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Войти через Facebook',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ColorTheme.appBarColor),
                foregroundColor:
                    MaterialStateProperty.all(ColorTheme.firstTextColor),
                shape: circulareShape,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
