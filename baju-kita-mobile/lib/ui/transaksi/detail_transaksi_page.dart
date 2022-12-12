import 'package:bajukita/model/transaksi.dart';
import 'package:flutter/material.dart';

class DetailTransaksiPage extends StatefulWidget {
  final Transaksi transaksi;

  const DetailTransaksiPage({required this.transaksi, Key? key})
      : super(key: key);

  @override
  State<DetailTransaksiPage> createState() => _DetailTransaksiPageState();
}

class _DetailTransaksiPageState extends State<DetailTransaksiPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Detail Transaksi Page'),
      ),
    );
  }
}
