import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/common/color_theme.dart';
import 'package:vk_example/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:vk_example/features/presentation/cubit/auth/auth_state.dart';
import 'package:vk_example/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:vk_example/features/presentation/cubit/credential/cretential_state.dart';
import 'package:vk_example/features/presentation/pages/home_page.dart';
import 'package:vk_example/features/presentation/pages/register_page.dart';
import 'package:vk_example/features/presentation/widgets/common.dart';

String _email = '';
String _password = '';
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
bool _isShowPassword = true;
final _scaffoldState = GlobalKey<ScaffoldState>();
late final FocusNode _passwordFocusNode;

void _submit(BuildContext context) {
  FocusScope.of(context).unfocus();

  if (_emailController.text.isEmpty) {
    toast('Напишите email');
    return;
  }
  if (_passwordController.text.isEmpty) {
    toast('Напишите пароль');
    return;
  }

  BlocProvider.of<CredentialCubit>(context).signInSumbit(
      email: _emailController.text, password: _passwordController.text);
}

class AuthPage extends StatefulWidget {
  static const String id = '/auth_page';
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  // final _formKey = GlobalKey<FormState>();

  final circulareShape = MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
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
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
            // Navigator.of(context).pushReplacementNamed(HomePage.id);
          }

          if (credentialState is CredentialFailure) {
            snackBarNetwork(
                msg: 'Неправельные данные', scaffoldState: _scaffoldState);
          }
        },
        builder: (context, credentialState) {
          if (CredentialState is CredentialLoading) {
            return loadingIndicatorProgressBar();
          }
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return const HomePage();
                  // return const HomePage();
                } else {
                  return const _BodyWidget();
                }
              },
            );
          }
          return const _BodyWidget();
        },
      ),
    );
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  State<_BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<_BodyWidget> {
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Мобильная версия поможет вам оставаться в МИСиС, даже если вы далеко от компьютера.',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Email',
                  ),
                  textInputAction: TextInputAction.next,
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context)
                  //       .requestFocus(_passwordFocusNode);
                  // },
                  // onSaved: (value) => _email = value!.trim(),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Что то с чем то';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10),
                TextField(
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Пароль',
                    // suffixIcon: InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       _isShowPassword =
                    //           _isShowPassword == false ? true : false;
                    //     });
                    //   },
                    // ),
                  ),

                  // onFieldSubmitted: (_) {
                  //   _submit(context);
                  // },
                  // onSaved: (value) => _password = value!.trim(),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Что то с чем то';
                  //   }
                  //   return null;
                  // },
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
                      'Войти через Canvas',
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
                'Пойти нахуй',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Color.fromARGB(39, 45, 128, 224)),
              ),
            ),
            Icon(Icons.navigate_next, color: ColorTheme.secondTextColor),
          ],
        ),
      ),
    );
  }
}
