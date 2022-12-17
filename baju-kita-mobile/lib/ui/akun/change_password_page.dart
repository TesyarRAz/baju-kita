import 'package:bajukita/data/static.dart';
import 'package:bajukita/model/login.dart';
import 'package:bajukita/repository/auth_repository.dart';
import 'package:bajukita/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _oldPasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password Lama',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password Baru',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Konfirmasi Password Baru',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: const Text(
                      'Ganti Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      _submit();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    var oldPassword = _oldPasswordController.text;
    var password = _passwordController.text;
    var confirmPassword = _confirmPasswordController.text;

    if (oldPassword.isEmpty || password.isEmpty || confirmPassword.isEmpty)
      return;

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Password konfirmasi tidak sesuai'),
          );
        },
      );
      return;
    }

    if (oldPassword == password) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Password baru harus berbeda dengan yang lama'),
          );
        },
      );
      return;
    }

    AuthRepository().changePassword(oldPassword, password).then((value) {
      if (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Berhasil ganti password'),
            );
          },
        ).then((value) => Navigator.of(context).pop());
      }
    }).catchError((error) {
      if (kDebugMode) {
        print((error as DioError).response?.data);
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Gagal ganti password'),
          );
        },
      );
    });
  }
}
