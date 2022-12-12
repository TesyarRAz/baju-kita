import 'dart:convert';

import 'package:bajukita/data/static.dart';
import 'package:bajukita/model/api_response.dart';
import 'package:flutter/foundation.dart';

class Repository {
  ApiResponse<T> parseResponse<T>(dynamic data) {
    return ApiResponse.fromJson<T>(data);
  }

  Map<String, dynamic> dioAuth() {
    if (kDebugMode) {
      print(DataStatic.token);
    }
    return {
      'Authorization': 'Bearer ${DataStatic.token}',
    };
  }
}
