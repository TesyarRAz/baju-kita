import 'package:bajukita/model/api_response.dart';
import 'package:bajukita/model/transaksi.dart';
import 'package:bajukita/repository/api.dart';
import 'package:bajukita/repository/repository.dart';
import 'package:dio/dio.dart';

class KeranjangRepository extends Repository {
  Future<List<DetailTransaksi>> list() async {
    var response = await Api.dio.get(
      '/keranjang',
      options: Options(
        headers: dioAuth(),
      ),
    );

    var data = parseResponse<List<dynamic>>(response.data);

    return data.data.map((e) => DetailTransaksi.fromJson(e)).toList();
  }

  Future<bool> store(int produkId, int qty) async {
    var response = await Api.dio.post(
      '/keranjang',
      data: {
        'produk_id': produkId,
        'qty': qty,
      },
      options: Options(
        headers: dioAuth(),
      ),
    );

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

  Future<bool> update(int produkId, int qty) async {
    var response = await Api.dio.put(
      '/keranjang/$produkId',
      data: {
        'qty': qty,
      },
      options: Options(
        headers: dioAuth(),
      ),
    );

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

  Future<bool> delete(int produkId) async {
    var response = await Api.dio.delete(
      '/keranjang/$produkId',
      options: Options(
        headers: dioAuth(),
      ),
    );

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }
}
