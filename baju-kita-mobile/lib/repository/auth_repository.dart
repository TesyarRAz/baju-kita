import 'package:bajukita/model/login.dart';
import 'package:bajukita/model/register.dart';
import 'package:bajukita/model/user.dart';
import 'package:bajukita/repository/api.dart';
import 'package:bajukita/repository/repository.dart';
import 'package:dio/dio.dart';

class AuthRepository extends Repository {
  Future<User?> user() async {
    var response = await Api.dio.get(
      '/user',
      options: Options(
        headers: dioAuth(),
      ),
    );

    if (response.statusCode == 401) {
      return null;
    }

    return User.fromJson(parseResponse(response.data).data);
  }

  Future<ResponseLogin?> login(Login login) async {
    var response = await Api.dio.post('/login', data: {
      'username': login.username,
      'password': login.password,
    });

    if (response.statusCode == 401) {
      return null;
    }

    return ResponseLogin.fromJson(parseResponse(response.data).data);
  }

  Future<User?> register(Register register) async {
    var response = await Api.dio.post('/register', data: {
      'name': register.name,
      'username': register.username,
      'email': register.email,
      'password': register.password,
    });

    if (response.statusCode == 401) {
      return null;
    }

    return User.fromJson(parseResponse(response.data).data);
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    var response = await Api.dio.post(
      '/change-password',
      data: {
        'old_password': oldPassword,
        'password': newPassword,
      },
      options: Options(
        headers: dioAuth(),
      ),
    );

    if (response.statusCode == 401) {
      return false;
    }

    return true;
  }
}
