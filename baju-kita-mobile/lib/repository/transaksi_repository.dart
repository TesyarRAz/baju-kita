import 'package:bajukita/model/transaksi.dart';
import 'package:bajukita/repository/api.dart';
import 'package:bajukita/repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TransaksiRepository extends Repository {
  Future<List<Transaksi>?> list() async {
    var response = await Api.dio.get(
      '/transaksi',
      options: Options(
        headers: dioAuth(),
      ),
    );

    if (response.statusCode != 200) {
      return null;
    }

    var data = parseResponse<List<dynamic>>(response.data);

    return data.data.map((e) => Transaksi.fromJson(e)).toList();
  }

  Future<Transaksi?> checkoutDitempat() async {
    var response = await Api.dio.post(
      '/transaksi',
      data: {
        'type': 'ambil_ditempat',
      },
      queryParameters: {
        'mode': 'checkout',
      },
      options: Options(
        headers: dioAuth(),
      ),
    );

    if (response.statusCode != 200) {
      return null;
    }

    return Transaksi.fromJson(parseResponse(response.data).data);
  }

  Future<Transaksi?> checkoutDiantarkan() async {
    var response = await Api.dio.post(
      '/transaksi',
      data: {
        'type': 'diantarkan',
      },
      queryParameters: {
        'mode': 'checkout',
      },
      options: Options(
        headers: dioAuth(),
      ),
    );

    if (response.statusCode != 200) {
      return null;
    }

    if (kDebugMode) {
      print(response.data);
    }

    return Transaksi.fromJson(parseResponse(response.data).data);
  }
}
