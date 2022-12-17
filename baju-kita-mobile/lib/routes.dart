import 'package:bajukita/model/produk.dart';
import 'package:bajukita/model/transaksi.dart';
import 'package:bajukita/ui/about/about_page.dart';
import 'package:bajukita/ui/akun/change_password_page.dart';
import 'package:bajukita/ui/home/home_page.dart';
import 'package:bajukita/ui/kategori/admin_kategori_modify_page.dart';
import 'package:bajukita/ui/keranjang/checkout_page.dart';
import 'package:bajukita/ui/keranjang/keranjang_page.dart';
import 'package:bajukita/ui/login/login_page.dart';
import 'package:bajukita/ui/produk/admin_produk_modify_page.dart';
import 'package:bajukita/ui/produk/detail_produk_page.dart';
import 'package:bajukita/ui/produk/produk_page.dart';
import 'package:bajukita/ui/qr/scan_qr_page.dart';
import 'package:bajukita/ui/register/register_page.dart';
import 'package:bajukita/ui/splash/splash_page.dart';
import 'package:bajukita/ui/support/support_page.dart';
import 'package:bajukita/ui/transaksi/admin_detail_transaksi_page.dart';
import 'package:bajukita/ui/transaksi/admin_transaksi_page.dart';
import 'package:bajukita/ui/transaksi/detail_transaksi_page.dart';
import 'package:bajukita/ui/transaksi/transaksi_page.dart';
import 'package:flutter/cupertino.dart';

typedef WidgetArgumentsBuilder = Widget Function(
    BuildContext, Object? arguments);

class Routes {
  Routes._();

  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const produk = '/produk';
  static const detailproduk = '/produk/detail';
  static const keranjang = '/keranjang';
  static const detailtransaksi = '/transaksi/detail';
  static const checkout = '/transaksi/checkout';

  static const adminprodukmodify = '/admin/produk/modify';
  static const adminkategorimodify = '/admin/kategori/modify';
  static const admintransaksi = '/admin/transaksi';
  static const admindetailtransaksi = '/admin/detailtransaksi';
  static const qrscan = '/qrscan';

  static const about = '/about';
  static const support = '/support';
  static const changepass = '/change-password';

  static final Map<String, WidgetArgumentsBuilder> _routeMap = {
    Routes.splash: (_, args) => const SplashPage(),
    Routes.home: (_, args) => const HomePage(),
    Routes.login: (_, args) => const LoginPage(),
    Routes.register: (_, args) => const RegisterPage(),
    Routes.produk: (_, args) => ProdukPage(
          initialKategoriId: (args as Map<String, dynamic>)['kategori_id'],
        ),
    Routes.detailproduk: (_, args) => DetailProdukPage(produk: args! as Produk),
    Routes.keranjang: (_, args) => const KeranjangPage(),
    Routes.detailtransaksi: (_, args) =>
        DetailTransaksiPage(transaksi: args! as Transaksi),
    Routes.adminprodukmodify: (_, args) =>
        AdminProdukModifyPage(produk: args != null ? (args as Produk) : null),
    Routes.adminkategorimodify: (_, args) => const AdminKategoriModifyPage(),
    Routes.admintransaksi: (_, args) => const AdminTransaksiPage(),
    Routes.admindetailtransaksi: (_, args) => const AdminDetailTransaksiPage(),
    Routes.checkout: (_, args) => CheckoutPage(transaksi: args! as Transaksi),
    Routes.qrscan: (_, args) => const ScanQrPage(),
    Routes.about: (_, args) => const AboutPage(),
    Routes.support: (_, args) => const SupportPage(),
    Routes.changepass: (_, args) => const ChangePasswordPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    var builder = _routeMap[settings.name]!;

    return PageRouteBuilder(
      pageBuilder: (context, _a, _b) => builder(context, settings.arguments),
      transitionsBuilder: (_, a, _b, page) => FadeTransition(
        opacity: a,
        child: page,
      ),
    );
  }
}
