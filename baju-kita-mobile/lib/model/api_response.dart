class ApiResponse<T> {
  T data;
  String message;
  int code;

  ApiResponse({
    required this.data,
    required this.message,
    required this.code,
  });

  static ApiResponse<T> fromJson<T>(Map<String, dynamic> map) {
    return ApiResponse<T>(
      data: map['data'],
      message: map['message'],
      code: map['code'],
    );
  }
}
