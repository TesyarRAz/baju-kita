import 'package:bajukita/model/register.dart';
import 'package:bajukita/repository/auth_repository.dart';
import 'package:bajukita/routes.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int step = 1;
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _usernameTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text(
              'BAJUKITA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Register'),
          ],
        ),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: step == 1,
                    child: Column(
                      children: [
                        _namaTextField(),
                        const SizedBox(height: 20),
                        _emailTextField(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buttonNextStep(),
                          ],
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: step == 2,
                    child: Column(
                      children: [
                        _usernameTextField(),
                        const SizedBox(height: 20),
                        _passwordTextField(),
                        const SizedBox(height: 20),
                        _passwordKonfirmasiTextField(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buttonPrevStep(),
                            _buttonRegistrasi(),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Textbox Nama
  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nama Lengkap",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Nama tidak boleh kosong";
        }
        return null;
      },
    );
  }

  Widget _namaBelakangTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nama Belakang",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Nama tidak boleh kosong";
        }
        return null;
      },
    );
  }

  // Textbox Email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        // Validasi harus diisi
        if (value?.isEmpty ?? true) {
          return "Email harus diisi";
        }
        // Validasi Email
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zAZ]{2,}))$';
        RegExp regex = RegExp(pattern.toString());
        if (!regex.hasMatch(value ?? '')) {
          return "Email Tidak Valid";
        }
        return null;
      },
    );
  }

  Widget _usernameTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Username",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      controller: _usernameTextboxController,
      validator: (value) {
        // Validasi harus diisi
        if (value?.isEmpty ?? true) {
          return "Username harus diisi";
        }
        return null;
      },
    );
  }

  // Textbox Password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if ((value?.length ?? 0) < 6) {
          return "Password Harus Diisi Minimal 6 Karakter";
        }
        return null;
      },
    );
  }

  // Textbox Konfirmasi Password
  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Konfirmasi Password",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        // Jika inputan tidak sama dengan passwrod
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi Password Tidak Sama";
        }
        return null;
      },
    );
  }

  Widget _buttonNextStep() {
    return ElevatedButton(
      child: const Text("Berikutnya"),
      onPressed: () {
        setState(() {
          step++;
        });
      },
    );
  }

  Widget _buttonPrevStep() {
    return ElevatedButton(
      child: const Text("Sebelumnya"),
      onPressed: () {
        setState(() {
          step--;
        });
      },
    );
  }

  // Tombol Registrasi
  Widget _buttonRegistrasi() {
    return ElevatedButton(
      child: const Text("Registrasi"),
      onPressed: () {
        var validate = _formkey.currentState?.validate();

        if (validate ?? false) {
          _submit();
        }
      },
    );
  }

  void _submit() {
    if (_isLoading) return;
    _isLoading = true;

    var register = Register(
      name: _namaTextboxController.text,
      email: _emailTextboxController.text,
      username: _usernameTextboxController.text,
      password: _passwordTextboxController.text,
    );

    AuthRepository().register(register).then((value) {
      _isLoading = false;
      if (!value) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Informasi'),
              content: Text('Gagal register, silahkan coba lagi'),
            );
          },
        );
        return;
      }

      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Informasi'),
            content: Text('Berhasil register, silahkan login'),
          );
        },
      ).then((value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.login, (route) => false);
      });
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Informasi'),
            content: Text('Gagal register, silahkan coba lagi'),
          );
        },
      );
    });
  }
}
