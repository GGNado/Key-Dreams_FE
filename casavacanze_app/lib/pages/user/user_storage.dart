import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../entity/user.dart';

/// A utility class for handling user data persistence.
class UserStorage {
  /// Saves the [User] object to persistent storage.
  ///
  /// [user] is converted to JSON and stored in SharedPreferences under the key 'user_data'.
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
