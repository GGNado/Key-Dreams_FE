import 'dart:async';
import 'dart:convert';

import 'package:casavacanze_app/pages/user/user_storage.dart';
import 'package:casavacanze_app/service/http_urls.dart';
import 'package:casavacanze_app/entity/user.dart';
import 'package:casavacanze_app/service/token.dart' as TokenStorage;
import 'package:casavacanze_app/service/token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Service class responsible for handling user authentication via HTTP.
class HttpLogin {
  /// Base host URL for the API.
  static const String host = HttpUrls.host;

  /// API endpoint for login.
  static const String api = HttpUrls.loginAPI;

  /// API endpoint for token validation.
  static const String apiValidate = HttpUrls.validateAPI;

  /// Authenticates a user with the provided credentials.
  ///
  /// Sends a POST request to the login API. If successful, retrieves the authorization token,
  /// creates a [User] object, and saves both the token and user data locally.
  ///
  /// [username] The user's username.
  /// [password] The user's password.
  ///
  /// Returns a [Future] that resolves to the authenticated [User].
  /// Throws an [Exception] if the login fails or the token is missing.
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

  /// Validates an existing authentication token.
  ///
  /// Sends a request to the validation API. If valid, refreshes the locally stored user data.
  ///
  /// [token] The JWT token to validate.
  ///
  /// Returns `true` if the token is valid, `false` otherwise.
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
