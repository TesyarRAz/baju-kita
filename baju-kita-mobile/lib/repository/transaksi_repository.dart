import 'dart:typed_data';

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

  Future<Transaksi?> checkoutDiantarkanFinal(
      Transaksi transaksi, Uint8List image, String filename) async {
    var response = await Api.dio.post(
      '/transaksi',
      data: FormData.fromMap({
        "receipt": MultipartFile.fromBytes(image, filename: filename),
        "recipient": transaksi.recipient,
        "address": transaksi.address,
        "transaksi_id": transaksi.id,
      }),
      queryParameters: {
        'mode': 'checkout_diantarkan',
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

  Future<Transaksi?> updateStatus(String status, int transaksiId) async {
    var response = await Api.dio.post(
      '/transaksi',
      data: {
        'session_status': status,
        'transaksi_id': transaksiId,
      },
      queryParameters: {
        'mode': 'update_status',
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

  Future<Transaksi?> showByInvoice(String invoice) async {
    var response = await Api.dio.get(
      '/transaksi',
      options: Options(
        headers: dioAuth(),
      ),
      queryParameters: {
        'byInvoice': invoice,
      },
    );

    if (response.statusCode != 200) {
      return null;
    }

    return Transaksi.fromJson(parseResponse(response.data).data);
  }
}
