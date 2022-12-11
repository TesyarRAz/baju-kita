import 'dart:convert';

import 'package:bajukita/model/api_response.dart';

class Repository {
  ApiResponse parseResponse(dynamic data) {
    return ApiResponse.fromJson(jsonDecode(data));
  }
}
