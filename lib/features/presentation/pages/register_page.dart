import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/common/color_theme.dart';
import 'package:vk_example/features/domain/entities/user_entity.dart';
import 'package:vk_example/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:vk_example/features/presentation/cubit/auth/auth_state.dart';
import 'package:vk_example/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:vk_example/features/presentation/cubit/credential/cretential_state.dart';
import 'package:vk_example/features/presentation/pages/home_page.dart';
import 'package:vk_example/features/presentation/widgets/common.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordAgainController = TextEditingController();

  void _submit(BuildContext context) {
    if (_usernameController.text.isEmpty) {
      toast('Напищшите ник');
      return;
    }
    if (_emailController.text.isEmpty) {
      toast('Напишите email');
      return;
    }
    if (_passwordController.text.isEmpty) {
      toast('Напишите password');
      return;
    }
    if (_passwordAgainController.text.isEmpty) {
      toast('Напишите снова свой password');
      return;
    }
    if (_passwordController.text == _passwordAgainController.text) {
    } else {
      toast("Пароль не совпадает");
      return;
    }

    BlocProvider.of<CredentialCubit>(context).signUpSumbit(
        user: UserEntity(
      userName: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if (credentialState is CredentialFailure) {
          snackBarNetwork(msg: "ошибка", context: context);
        }
      },
      builder: (context, credentialState) {
        if (credentialState is CredentialLoading) {
          return loadingIndicatorProgressBar();
        }
        if (credentialState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return const HomePage();
              } else {
                return _bodyWidget();
              }
            },
          );
        }
        return _bodyWidget();
      },
    );
    // );
  }

  Widget _bodyWidget() {
    final circulareShape = MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
    var headerTextStyle = const TextStyle(
        fontSize: 14,
        color: ColorTheme.thirdColor,
        fontWeight: FontWeight.w300);
    return Scaffold(
      backgroundColor: ColorTheme.colorTheme,
      appBar: AppBar(
        backgroundColor: ColorTheme.appBarColor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: ColorTheme.appBarColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Информация профиля',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'Вашим друзьям будет проще вас найти, если вы укажете информацию о себе.',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          color: ColorTheme.thirdColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Email',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Username',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Пароль',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordAgainController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Повторите пароль',
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _submit(context);
                          },
                          child: const Text('Окей'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ColorTheme.buttonColor),
                            foregroundColor: MaterialStateProperty.all(
                                ColorTheme.appBarColor),
                            shape: circulareShape,
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Уже заригистрировались?',
                            style: headerTextStyle),
                        TextSpan(
                            text: 'Войти',
                            style: const TextStyle(
                              color: ColorTheme.firstTextColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                            recognizer: TapGestureRecognizer()),
                      ],
                    )),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
