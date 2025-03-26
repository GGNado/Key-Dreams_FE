import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int id;
  final String username;
  final String nome;
  final String cognome;
  final String roles;
  final String token;

  User({required this.id, required this.nome, required this.cognome, required this.username, required this.roles, required this.token});

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

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'nome': nome,
      'cognome': cognome,
      'roles': roles,
    };
  }

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
