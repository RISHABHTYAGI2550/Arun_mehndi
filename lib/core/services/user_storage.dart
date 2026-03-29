import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

class UserStorage {

  static const String userKey = "user_data";
  static const String tokenKey = "auth_token";

  /// SAVE USER
  static Future<void> saveUser(UserModel user) async {

    final prefs = await SharedPreferences.getInstance();

    prefs.setString(userKey, jsonEncode(user.toJson()));
  }

  /// GET USER
  static Future<UserModel?> getUser() async {

    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString(userKey);

    if(data == null) return null;

    return UserModel.fromJson(jsonDecode(data));
  }

  /// SAVE TOKEN
  static Future<void> saveToken(String token) async {

    final prefs = await SharedPreferences.getInstance();

    prefs.setString(tokenKey, token);
  }

  /// GET TOKEN
  static Future<String?> getToken() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(tokenKey);
  }

  /// LOGOUT
  static Future<void> clear() async {

    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }
}