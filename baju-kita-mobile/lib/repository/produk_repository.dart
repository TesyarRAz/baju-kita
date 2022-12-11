import 'package:bajukita/model/api_response.dart';
import 'package:bajukita/model/produk.dart';
import 'package:bajukita/repository/api.dart';
import 'package:bajukita/repository/repository.dart';

class ProdukRepository extends Repository {
  Future<List<Produk>?> listProduk() async {
    var response = await Api.dio.get('/produk');

    var data = parseResponse(response.data);

    return data.data.map((e) => Produk.fromJson(e)).toList();
  }
}
