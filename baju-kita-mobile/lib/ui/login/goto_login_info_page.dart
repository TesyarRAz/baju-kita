import 'package:bajukita/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class GotoLoginInfoPage extends StatelessWidget {
  const GotoLoginInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Anda belum login, silahkan login terlebih dahulu',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () => Navigator.of(context).pushNamed(Routes.login),
            ),
          ],
        ),
      ),
    );
  }
}
