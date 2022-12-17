class User {
  final String name;
  final String email;
  final String username;
  final String? password;
  final String role;

  User({
    required this.name,
    required this.email,
    required this.username,
    this.password,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      username: map['username'],
      password: map.containsKey('password') ? map['password'] : null,
      role: map['role'],
    );
  }
}
