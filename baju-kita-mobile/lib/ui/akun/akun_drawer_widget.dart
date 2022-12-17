import 'package:flutter/material.dart';

class AkunDrawerWidget extends StatelessWidget {
  const AkunDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Nickname'),
            accountEmail: const Text('email@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/avatar.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          // ListTile(
          //   leading: const Icon(Icons.list),
          //   title: const Text('Kategori'),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: const Icon(Icons.phone),
          //   title: const Text('Kontak Kami'),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: const Icon(Icons.people),
          //   title: const Text('Dukungan'),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: const Icon(Icons.info_outline),
          //   title: const Text('Tentang'),
          //   onTap: () => null,
          // ),
        ],
      ),
    );
  }
}
