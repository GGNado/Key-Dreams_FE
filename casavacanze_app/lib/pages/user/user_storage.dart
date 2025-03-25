import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../entity/user.dart';

class UserStorage {
  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('user_data', userJson);
  }

  // static Future<User?> loadUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final json = prefs.getString('user_data');
  //   if (json != null) {
  //     final map = jsonDecode(json);
  //     return User.fromJson(map);
  //   }
  //   return null;
  // }
}