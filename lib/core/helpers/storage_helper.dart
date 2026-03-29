import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /*
  ---------------------------
  TOKEN
  ---------------------------
  */

  static Future<void> saveToken(String token) async {
    await _storage.write(key: "token", value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }

  static Future<void> removeToken() async {
    await _storage.delete(key: "token");
  }

  /*
  ---------------------------
  USER DATA (optional)
  ---------------------------
  */

  static Future<void> saveUser(String userJson) async {
    await _storage.write(key: "user", value: userJson);
  }

  static Future<String?> getUser() async {
    return await _storage.read(key: "user");
  }

  /*
  ---------------------------
  CLEAR ALL (LOGOUT)
  ---------------------------
  */

  static Future<void> logout() async {
    await _storage.deleteAll();
  }
}