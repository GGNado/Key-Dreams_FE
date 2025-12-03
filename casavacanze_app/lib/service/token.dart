import 'package:shared_preferences/shared_preferences.dart';

/// Saves the authentication token to persistent storage.
///
/// [token] is the JWT string to be stored.
Future<void> saveToken(String token) async {
  print('Saving token: $token');
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

/// Retrieves the authentication token from persistent storage.
///
/// Returns the token string if it exists, or `null` otherwise.
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

/// Removes the authentication token from persistent storage.
///
/// Use this function during logout to clear credentials.
Future<void> clearToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
}

/// Removes the user data from persistent storage.
///
/// Clears the 'user_data' key from SharedPreferences.
Future<void> clearUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_data');
}
