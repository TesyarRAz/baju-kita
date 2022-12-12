import 'dart:convert';

import 'package:bajukita/model/produk.dart';
import 'package:bajukita/model/user.dart';

class DetailTransaksi {
  int id;
  int userId;
  int totalPrice;
  int produkId;
  int qty;

  Produk? produk;
  User? user;

  DetailTransaksi({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.produkId,
    required this.qty,
    this.produk,
    this.user,
  });

  factory DetailTransaksi.fromJson(Map<String, dynamic> map) {
    return DetailTransaksi(
      id: map['id'],
      userId: map['user_id'],
      totalPrice: map['total_price'],
      produkId: map['produk_id'],
      qty: map['qty'],
      produk: map.containsKey('produk') ? Produk.fromJson(map['produk']) : null,
      user: map.containsKey('user') ? User.fromJson(map['user']) : null,
    );
  }
}

class Transaksi {
  int id;
  int userId;
  String invoiceCode;
  int totalPrice;
  String type;
  String status;

  List<DetailTransaksi>? detailTransaksis;

  Transaksi({
    required this.id,
    required this.userId,
    required this.invoiceCode,
    required this.totalPrice,
    required this.type,
    required this.status,
    this.detailTransaksis,
  });

  factory Transaksi.fromJson(Map<String, dynamic> map) {
    return Transaksi(
      id: map['id'],
      userId: map['user_id'],
      invoiceCode: map['invoice_code'],
      totalPrice: map['total_price'],
      type: map['type'],
      status: map['status'],
      detailTransaksis: map.containsKey('detail_transaksis')
          ? (map['detail_transaksis'] as List<dynamic>)
              .map((e) => DetailTransaksi.fromJson(e))
              .toList()
          : null,
    );
  }
}
