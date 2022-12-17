import 'package:dio/dio.dart';

class Api {
  Api._();

  // static const base = "http://192.168.118.1:8000";
  static const base = "http://117.102.69.173:8080";
  static const api = "$base/api";

  static final dio = Dio(BaseOptions(
    baseUrl: api,
    contentType: 'application/json',
    responseType: ResponseType.json,
  ));
}
