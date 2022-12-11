import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdminKategoriModifyPage extends StatefulWidget {
  const AdminKategoriModifyPage({Key? key}) : super(key: key);

  @override
  State<AdminKategoriModifyPage> createState() =>
      _AdminKategoriModifyPageState();
}

class _AdminKategoriModifyPageState extends State<AdminKategoriModifyPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Admin Kategori Modify'),
      ),
    );
  }
}
