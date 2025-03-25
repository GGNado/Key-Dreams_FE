import 'dart:async';
import 'dart:convert';

import 'package:casavacanze_app/pages/user/user_storage.dart';
import 'package:casavacanze_app/service/http_urls.dart';
import 'package:casavacanze_app/entity/user.dart';
import 'package:casavacanze_app/service/token.dart' as TokenStorage;
import 'package:casavacanze_app/service/token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpLogin {
  static const String host = HttpUrls.host;
  static const String api = HttpUrls.loginAPI;
  static const String apiValidate = HttpUrls.validateAPI;

  static Future<User> loginAndReturnUser(
    String username,
    String password,
  ) async {
    print("Entro in loginAndReturnUser");
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
        final user = User.fromToken(token);
        //final user = User.fromJson(json);
        await TokenStorage.saveToken(token);
        print(user.username);
        UserStorage.saveUser(user);
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
      print("Token valido");
      final user = User.fromToken(token);
      UserStorage.saveUser(user);
      print("user salvato: ${user.cognome}");
      return true;
    } else {
      return false;
    }
  }
}
