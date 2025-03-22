import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToken(String token) async {
  print('Saving token: $token');
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

Future<void> clearToken() async {
  print("Pulisco il token");
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
}
