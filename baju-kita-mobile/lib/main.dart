import 'package:bajukita/routes.dart';
import 'package:bajukita/ui/home/home_page.dart';
import 'package:bajukita/ui/kategori/admin_kategori_modify_page.dart';
import 'package:bajukita/ui/keranjang/keranjang_page.dart';
import 'package:bajukita/ui/login/login_page.dart';
import 'package:bajukita/ui/produk/admin_produk_modify_page.dart';
import 'package:bajukita/ui/produk/detail_produk_page.dart';
import 'package:bajukita/ui/register/register_page.dart';
import 'package:bajukita/ui/transaksi/admin_detail_transaksi_page.dart';
import 'package:bajukita/ui/transaksi/admin_transaksi_page.dart';
import 'package:bajukita/ui/transaksi/detail_transaksi_page.dart';
import 'package:bajukita/ui/transaksi/transaksi_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAJUKITA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          secondary: Colors.white,
        ),
      ),
      initialRoute: Routes.home,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
