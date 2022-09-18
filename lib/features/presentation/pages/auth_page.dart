import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/common/color_theme.dart';
import 'package:vk_example/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:vk_example/features/presentation/cubit/auth/auth_state.dart';
import 'package:vk_example/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:vk_example/features/presentation/cubit/credential/cretential_state.dart';
import 'package:vk_example/features/presentation/pages/home_page.dart';
import 'package:vk_example/features/presentation/widgets/common.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _submit(BuildContext context) {
    if (emailController.text.isEmpty) {
      toast('Напишите email');
      return;
    }
    if (passwordController.text.isEmpty) {
      toast('Напишите пароль');
      return;
    }

    BlocProvider.of<CredentialCubit>(context).signInSumbit(
        email: emailController.text, password: passwordController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  final circulareShape = MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }

        if (credentialState is CredentialFailure) {
          snackBarNetwork(msg: 'Неправельные данные', context: context);
        }
      },
      builder: (context, credentialState) {
        if (CredentialState is CredentialLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
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
  }

  Widget _bodyWidget() {
    final circulareShape = MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Вход ВМИСиС',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
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
                  controller: passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Пароль',
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/register_page'),
                  child: const Text('Зарегистрироватся'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorTheme.registerColor),
                    foregroundColor:
                        MaterialStateProperty.all(ColorTheme.appBarColor),
                    shape: circulareShape,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
