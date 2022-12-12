import 'package:bajukita/data/static.dart';
import 'package:bajukita/ui/akun/akun_page.dart';
import 'package:bajukita/ui/dashboard/dashboard_page.dart';
import 'package:bajukita/ui/keranjang/keranjang_page.dart';
import 'package:bajukita/ui/login/goto_login_info_page.dart';
import 'package:bajukita/ui/notifikasi/notifikasi_page.dart';
import 'package:bajukita/ui/produk/produk_page.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

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
    DataStatic.user != null ? const NotifikasiPage() : GotoLoginInfoPage(),
    DataStatic.user != null ? const AkunPage() : GotoLoginInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'BAJUKITA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            if (DataStatic.user != null)
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart),
              ),
          ],
        ),
        body: page[_selectedPage],
        extendBody: true,
        bottomNavigationBar: DotNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: _selectedPage,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          enablePaddingAnimation: false,
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.shopping_bag),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.notifications),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.account_box),
            ),
          ],
          onTap: (index) => setState(() {
            _selectedPage = index;
          }),
        ),
      ),
    );
  }
}
