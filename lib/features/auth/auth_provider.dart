import 'dart:convert';
import 'package:flutter/material.dart';

import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../core/helpers/storage_helper.dart';

class AuthProvider extends ChangeNotifier {

  String? token;
  Map<String, dynamic>? user;

  bool get isLoggedIn => token != null;

  /*
  -------------------------
  REGISTER
  -------------------------
  */

  Future<bool> registerUser(
      String name,
      String email,
      String phone,
      String password
      ) async {

    try {

      final data = await ApiClient.post(
        ApiEndpoints.register,
        {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password
        },
      );

      /// REGISTER SUCCESS → AUTO LOGIN
      if(data["status"] == true){

        return await login(email, password);

      }

      return false;

    } catch(e){

      debugPrint("REGISTER ERROR: $e");

      return false;

    }

  }

  /*
  -------------------------
  LOGIN
  -------------------------
  */

  Future<bool> login(String email, String password) async {

    try {

      final data = await ApiClient.post(
        ApiEndpoints.login,
        {
          "email": email,
          "password": password
        },
      );

      if(data["status"] == true){

        /// TOKEN
        token = data["data"]["token"];

        /// USER
        user = data["data"]["user"];

        /// SAVE TOKEN
        await StorageHelper.saveToken(token!);

        /// SAVE USER
        await StorageHelper.saveUser(jsonEncode(user));

        debugPrint("TOKEN SAVED: $token");
        debugPrint("USER SAVED: $user");

        notifyListeners();

        return true;

      }

      return false;

    } catch(e){

      debugPrint("LOGIN ERROR: $e");

      return false;

    }

  }

  /*
  -------------------------
  AUTO LOGIN
  -------------------------
  */

  Future<void> loadUser() async {

    token = await StorageHelper.getToken();

    String? userJson = await StorageHelper.getUser();

    if(userJson != null){
      user = jsonDecode(userJson);
    }

    notifyListeners();

  }

  /*
  -------------------------
  LOGOUT
  -------------------------
  */

  Future<void> logout() async {

    token = null;
    user = null;

    await StorageHelper.logout();

    notifyListeners();

  }

}