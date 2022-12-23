import 'package:bajukita/data/static.dart';
import 'package:bajukita/model/login.dart';
import 'package:bajukita/repository/auth_repository.dart';
import 'package:bajukita/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'BAJUKITA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/images/about.jpg',
            width: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Anda belum punya akun?'),
                        TextButton(
                          child: const Text('Register'),
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.register);
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _submit();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    var username = _usernameController.text;
    var password = _passwordController.text;

    AuthRepository().login(Login(username: username, password: password)).then(
        (login) {
      if (login?.user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username atau password salah'),
          ),
        );

        return;
      }

      // DataStatic.user
      DataStatic.token = login?.token;
      DataStatic.user = login?.user;

      SharedPreferences.getInstance().then((pref) {
        pref.setString("token", login?.token ?? '');
      });

      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.home,
        (route) => false,
      );
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Username atau password salah'),
          );
        },
      );
    });
  }
}
