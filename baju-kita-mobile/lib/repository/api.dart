import 'package:dio/dio.dart';

class Api {
  Api._();

  static const base = "http://localhost:8000/api";

  static final dio = Dio(BaseOptions(
    baseUrl: base,
    contentType: 'application/json',
    responseType: ResponseType.json,
  ));
}
