import 'package:flutter/material.dart';
import 'package:vk_example/bloc/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/models/theme_model.dart';
import 'package:vk_example/page/home_page.dart';
import 'package:vk_example/page/register_page.dart';

class AuthPage extends StatefulWidget {
  static const String id = '/auth_page';
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _email = '';
  String _password = '';

  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    context.read<AuthCubit>().singIn(email: _email, password: _password);
  }

  final circulareShape = MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (prevState, currState) {
      if (currState is AuthSingedIn) {
        Navigator.of(context).pushReplacementNamed(HomePage.id);
      }

      if (currState is AuthFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2), content: Text(currState.message)));
      }
    }, builder: (context, state) {
      if (State is AuthLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        backgroundColor: ColorTheme.colorTheme,
        appBar: AppBar(
          backgroundColor: ColorTheme.appBarColor,
          elevation: 0,
          title: const Text(
            'В МИСиС',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _InstallApp(),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                color: ColorTheme.appBarColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Мобильная версия поможет вам оставаться в МИСиС, даже если вы далеко от компьютера.',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 15),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Email',
                              ),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                              onSaved: (value) => _email = value!.trim(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Что то с чем то';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              focusNode: _passwordFocusNode,
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Пароль',
                              ),
                              onFieldSubmitted: (_) {
                                _submit(context);
                              },
                              onSaved: (value) => _password = value!.trim(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Что то с чем то';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _submit(context);
                                  },
                                  child: const Text('Войти'),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorTheme.buttonColor),
                                    foregroundColor: MaterialStateProperty.all(
                                        ColorTheme.appBarColor),
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
                                  backgroundColor: MaterialStateProperty.all(
                                      ColorTheme.appBarColor),
                                  foregroundColor: MaterialStateProperty.all(
                                      ColorTheme.firstTextColor),
                                  shape: circulareShape,
                                ),
                              ),
                            ),
                            const SizedBox(height: 60),
                            const Text(
                              'Впервые в МИСиС',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: ColorTheme.thirdColor),
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed(RegisterPage.id);
                                  },
                                  child: const Text('Зарегистрироваться'),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorTheme.registerColor),
                                    foregroundColor: MaterialStateProperty.all(
                                        ColorTheme.appBarColor),
                                    shape: circulareShape,
                                  ),
                                )),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'Войти через Canvas',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      ColorTheme.appBarColor),
                                  foregroundColor: MaterialStateProperty.all(
                                      ColorTheme.firstTextColor),
                                  shape: circulareShape,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
        ),
      );
    });
  }
}

class _InstallApp extends StatefulWidget {
  const _InstallApp({Key? key}) : super(key: key);

  @override
  State<_InstallApp> createState() => _InstallAppState();
}

class _InstallAppState extends State<_InstallApp> {
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
