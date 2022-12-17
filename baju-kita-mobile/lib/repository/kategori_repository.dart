import 'package:bajukita/model/kategori.dart';
import 'package:bajukita/repository/api.dart';
import 'package:bajukita/repository/repository.dart';
import 'package:dio/dio.dart';

class KategoriRepository extends Repository {
  Future<List<Kategori>?> list() async {
    var response = await Api.dio.get('/kategori');

    var data = parseResponse<List<dynamic>>(response.data);

    return data.data.map((e) => Kategori.fromJson(e)).toList();
  }

  Future<bool> store(String kategori) async {
    var response = await Api.dio.post(
      '/kategori',
      data: {
        'name': kategori,
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

  Future<bool> delete(int kategoriId) async {
    var response = await Api.dio.delete(
      '/kategori/$kategoriId',
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
