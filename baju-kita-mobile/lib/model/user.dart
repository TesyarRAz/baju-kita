class User {
  final String name;
  final String email;
  final String username;
  final String? password;

  User({
    required this.name,
    required this.email,
    required this.username,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      username: map['username'],
      password: map.containsKey('password') ? map['password'] : null,
    );
  }
}
