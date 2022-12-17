import 'package:bajukita/model/api_response.dart';
import 'package:bajukita/model/produk.dart';
import 'package:bajukita/repository/api.dart';
import 'package:bajukita/repository/repository.dart';
import 'package:dio/dio.dart';

class ProdukRepository extends Repository {
  Future<List<Produk>?> recommended() async {
    var response = await Api.dio.get('/produk', queryParameters: {
      'type': 'recommended',
    });

    var data = parseResponse<List<dynamic>>(response.data);

    return data.data.map((e) => Produk.fromJson(e)).toList();
  }

  Future<List<Produk>?> list({int? kategoriId, String? search}) async {
    var query = <String, dynamic>{};

    if (kategoriId != null) {
      query['kategori_id'] = kategoriId;
    }

    if (search != null) {
      query['search'] = search;
    }

    var response = await Api.dio.get('/produk', queryParameters: query);

    var data = parseResponse<List<dynamic>>(response.data);

    return data.data.map((e) => Produk.fromJson(e)).toList();
  }

  Future<bool> delete(int produkId) async {
    var response = await Api.dio.delete(
      '/produk/$produkId',
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
