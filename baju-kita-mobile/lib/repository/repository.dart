import 'dart:convert';

import 'package:bajukita/model/api_response.dart';

class Repository {
  ApiResponse<T> parseResponse<T>(dynamic data) {
    return ApiResponse.fromJson<T>(data);
  }
}
