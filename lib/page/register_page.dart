import 'package:flutter/material.dart';
import 'package:vk_example/model/theme.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ColorTheme.colorTheme,
        appBar: AppBar(
          backgroundColor: ColorTheme.appBarColor,
          elevation: 0,
          leading: const Icon(
            Icons.arrow_back,
            color: ColorTheme.firstTextColor,
          ),
        ),
        body: _RegisterWidget(),
      ),
    );
  }
}

class _RegisterWidget extends StatelessWidget {
  const _RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorTheme.appBarColor,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Text(
            'Информация профиля',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Вашим друзьям будет проще вас найти, если вы укажете информацию о себе.',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
                color: ColorTheme.thirdColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
