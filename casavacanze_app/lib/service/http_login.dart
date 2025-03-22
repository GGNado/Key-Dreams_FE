import 'dart:convert';

import 'package:casavacanze_app/entity/user.dart';
import 'package:casavacanze_app/service/token.dart' as TokenStorage;
import 'package:http/http.dart' as http;

class HttpLogin {
  static const String host = "http://172.16.218.64:8080";
  static const String api = "/api/utente/login";
  static const String apiValidate = "/api/utente/validate";

  static Future<User> loginAndReturnUser(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$host$api'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final token = response.headers['authorization'];

      if (token != null) {
        //final Map<String, dynamic> json = jsonDecode(response.body);
        final user = User.fromJson(username, token);
        await TokenStorage.saveToken(token);
        print(user.username);
        return user;
      } else {
        throw Exception('Token non trovato negli header');
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<bool> validateToken(String token) async {
    if (token.isEmpty) {
      return false;
    }
    final response = await http.post(
      Uri.parse('$host$apiValidate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
