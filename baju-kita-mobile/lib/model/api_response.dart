class ApiResponse {
  dynamic data;
  String message;
  int code;

  ApiResponse({
    required this.data,
    required this.message,
    required this.code,
  });

  static ApiResponse fromJson(Map<String, dynamic> map) {
    return ApiResponse(
      data: map['data'],
      message: map['message'],
      code: map['code'],
    );
  }
}
