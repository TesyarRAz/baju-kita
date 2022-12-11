import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdminDetailTransaksiPage extends StatefulWidget {
  const AdminDetailTransaksiPage({Key? key}) : super(key: key);

  @override
  State<AdminDetailTransaksiPage> createState() =>
      _AdminDetailTransaksiPageState();
}

class _AdminDetailTransaksiPageState extends State<AdminDetailTransaksiPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Admin Detail Transaksi'),
      ),
    );
  }
}
