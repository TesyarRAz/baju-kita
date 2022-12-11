import 'package:bajukita/model/kategori.dart';
import 'package:bajukita/repository/api.dart';
import 'package:bajukita/repository/repository.dart';

class KategoriRepository extends Repository {
  Future<List<Kategori>?> listKategori() async {
    var response = await Api.dio.get('/kategori');

    var data = parseResponse(response.data);

    return data.data.map((e) => Kategori.fromJson(e)).toList();
  }
}