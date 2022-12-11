import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdminProdukModifyPage extends StatefulWidget {
  const AdminProdukModifyPage({Key? key}) : super(key: key);

  @override
  State<AdminProdukModifyPage> createState() => _AdminProdukModifyPageState();
}

class _AdminProdukModifyPageState extends State<AdminProdukModifyPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Admin Produk Modify'),
      ),
    );
  }
}
