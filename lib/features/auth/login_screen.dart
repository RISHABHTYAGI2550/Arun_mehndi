import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../core/helpers/storage_helper.dart';
import '../../widgets/main_layout.dart';
import 'create_account_screen.dart';
import 'forgot_password_screen.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/services/user_storage.dart';
import '../../models/user_model.dart';

void handleLoginSuccess(Map<String, dynamic> response) async {

  // API response se user model banega
  UserModel user = UserModel.fromJson(response);

  // User phone storage me save hoga
  await UserStorage.saveUser(user);

}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool hidePassword = true;

  /*
  -------------------------
  LOGIN FUNCTION
  -------------------------
  */

  Future<void> login() async {

    if(emailController.text.trim().isEmpty){
      showMessage("Enter email or phone");
      return;
    }

    if(passwordController.text.trim().length < 6){
      showMessage("Password must be at least 6 characters");
      return;
    }

    setState(() {
      loading = true;
    });

    try{

      final data = await ApiClient.post(
        ApiEndpoints.login,
        {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim()
        },
      );

      if(data["status"] == true){

        /// TOKEN
        String token = data["data"]["token"];

        /// USER
        Map<String,dynamic> user = data["data"]["user"];

        /// SAVE TOKEN
        await StorageHelper.saveToken(token);

        /// SAVE USER
        await StorageHelper.saveUser(jsonEncode(user));

        print("TOKEN SAVED: $token");
        print("USER SAVED: $user");

        if(!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MainNavigationScreen(),
          ),
        );

      }else{

        showMessage(data["message"] ?? "Login failed");

      }

    }catch(e){

      showMessage("Server error. Please try again.");

    }

    if(mounted){
      setState(() {
        loading = false;
      });
    }

  }

  /*
  -------------------------
  MESSAGE
  -------------------------
  */

  void showMessage(String msg){
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: const Color(0xff121212),

      body: SafeArea(

        child: Center(

          child: SingleChildScrollView(

            child: Container(

              width: width > 500 ? 420 : double.infinity,

              padding: const EdgeInsets.all(24),

              child: Column(

                children: [

                  const SizedBox(height: 10),

                  /// LOGO
                  Center(
                    child: Image.asset(
                      "assets/images/splash_logo.jpeg",
                      height: 80,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome Back",
                      style: AppTextStyles.heading,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Login to continue learning",
                      style: AppTextStyles.body,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// EMAIL
                  TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline),
                      hintText: "Email or Phone",
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xff1E1E1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// PASSWORD
                  TextField(
                    controller: passwordController,
                    obscureText: hidePassword,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xff1E1E1E),

                      suffixIcon: IconButton(
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: (){
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// FORGOT PASSWORD
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// LOGIN BUTTON
                  GestureDetector(
                    onTap: loading ? null : login,

                    child: Container(

                      height: 52,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Center(
                        child: loading
                            ? const CircularProgressIndicator(
                            color: Colors.white)
                            : const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white60),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateAccountScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}