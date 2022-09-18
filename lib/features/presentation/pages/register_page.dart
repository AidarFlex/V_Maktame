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
      appBar: AppBar(
        backgroundColor: ColorTheme.appBarColor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 64),
                Text(
                  'Регистрация',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
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
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _submit(context);
                    },
                    child: const Text('Окей'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorTheme.buttonColor),
                      foregroundColor:
                          MaterialStateProperty.all(ColorTheme.appBarColor),
                      shape: circulareShape,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
