import 'package:bajukita/data/static.dart';
import 'package:bajukita/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({Key? key}) : super(key: key);

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            Container(
              height: 150,
              color: Colors.black,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      DataStatic.user?.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            ListTile(
              title: const Text(
                'Tentang Kami',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.about);
              },
            ),
            ListTile(
              title: const Text(
                'Support',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.support);
              },
            ),
            ListTile(
              title: const Text(
                'Ganti Password',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.changepass);
              },
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Pertanyaan'),
                      content: const Text('Yakin ingin logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            DataStatic.user = null;
                            DataStatic.token = null;
                            SharedPreferences.getInstance().then((pref) {
                              pref.remove('token');
                            });

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.home, (route) => false);
                          },
                          child: const Text('Ya'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Tidak'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
