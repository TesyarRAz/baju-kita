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
import 'package:flutter/cupertino.dart';

class Routes {
  Routes._();

  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const detailproduk = '/produk/:id';
  static const keranjang = '/keranjang';
  static const transaksi = '/transaksi';
  static const detailtransaksi = '/transaksi/:id';

  static const adminprodukmodify = '/admin/produk/modify';
  static const adminkategorimodify = '/admin/kategori/modify';
  static const admintransaksi = '/admin/transaksi';
  static const admindetailtransaksi = '/admin/detailtransaksi';

  static final Map<String, WidgetBuilder> _routeMap = {
    Routes.home: (_) => const HomePage(),
    Routes.login: (_) => const LoginPage(),
    Routes.register: (_) => const RegisterPage(),
    Routes.detailproduk: (_) => const DetailProdukPage(),
    Routes.keranjang: (_) => const KeranjangPage(),
    Routes.transaksi: (_) => const TransaksiPage(),
    Routes.detailtransaksi: (_) => const DetailTransaksiPage(),
    Routes.adminprodukmodify: (_) => const AdminProdukModifyPage(),
    Routes.adminkategorimodify: (_) => const AdminKategoriModifyPage(),
    Routes.admintransaksi: (_) => const AdminTransaksiPage(),
    Routes.admindetailtransaksi: (_) => const AdminDetailTransaksiPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    var builder = _routeMap[settings.name]!;

    return PageRouteBuilder(
      pageBuilder: (context, _a, _b) => builder(context),
      transitionsBuilder: (_, a, _b, page) => FadeTransition(
        opacity: a,
        child: page,
      ),
    );
  }
}
