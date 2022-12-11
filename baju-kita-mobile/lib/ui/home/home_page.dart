import 'package:bajukita/ui/akun/akun_page.dart';
import 'package:bajukita/ui/dashboard/dashboard_page.dart';
import 'package:bajukita/ui/keranjang/keranjang_page.dart';
import 'package:bajukita/ui/produk/produk_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  final page = [
    const DashboardPage(),
    const ProdukPage(),
    const KeranjangPage(),
    const AkunPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop_2),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
          ),
        ],
        onTap: (index) => setState(() {
          _selectedPage = index;
        }),
      ),
    );
  }
}
