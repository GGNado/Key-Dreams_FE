class User {
  final String username;
  final String roles;
  final String token;

  User({required this.username, required this.roles, required this.token});

  factory User.fromJson(String username, String token) {
    return User(username: username, roles: "", token: token);
  }
}
