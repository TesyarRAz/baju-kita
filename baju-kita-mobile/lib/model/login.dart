import 'user.dart';

class Login {
  final String username;
  final String password;

  Login({
    required this.username,
    required this.password,
  });
}

class ResponseLogin {
  final User? user;
  final String token;

  ResponseLogin({
    this.user,
    required this.token,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> map) {
    return ResponseLogin(
      token: map['token'],
      user: map.containsKey('user') ? User.fromJson(map['user']) : null,
    );
  }
}
