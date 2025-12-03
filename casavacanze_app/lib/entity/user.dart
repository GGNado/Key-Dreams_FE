import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Represents a user entity in the system.
///
/// Contains user information derived from a JWT token, including identity and roles.
class User {
  /// The unique identifier of the user.
  final int id;

  /// The username used for login.
  final String username;

  /// The first name of the user.
  final String nome;

  /// The last name of the user.
  final String cognome;

  /// The roles assigned to the user (e.g., admin, user).
  final String roles;

  /// The authentication token associated with the user.
  final String token;

  /// Creates a [User] instance.
  ///
  /// All parameters are required.
  User({required this.id, required this.nome, required this.cognome, required this.username, required this.roles, required this.token});

  /// Creates a [User] instance by decoding a JWT token.
  ///
  /// [token] is the JWT string.
  /// Returns a populated [User] object extracting fields like `id`, `username`, `nome`, etc. from the token payload.
  factory User.fromToken(String token) {
    // devo prendere il token e decodificarlo per prendere nome e cognome
    final decodedToken = JwtDecoder.decode(token);
    final id = decodedToken['id'] ?? -1;
    final username = decodedToken['username'] ?? '';
    final nome = decodedToken['nome'] ?? '';
    final cognome = decodedToken['cognome'] ?? '';
    final roles = decodedToken['roles'] ?? '';

    return User(id: id, username: username, roles: roles, token: token, nome: nome, cognome: cognome);
  }

  /// Converts the [User] instance to a JSON map.
  ///
  /// Returns a map with selected user fields. Note that sensitive info or ID might be excluded depending on usage.
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'nome': nome,
      'cognome': cognome,
      'roles': roles,
    };
  }

  /// Loads the user data from persistent storage (SharedPreferences).
  ///
  /// Checks for stored 'user_data' and reconstructs the [User] using the stored token.
  /// Returns a [User] object if found, or `null` otherwise.
  static Future<User?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user_data');
    if (jsonString != null) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return User.fromToken(json['token']);
    }
    return null;
  }
}
