import 'package:flutter/material.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {

  final String identity;

  const ResetPasswordScreen({super.key, required this.identity});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool loading = false;
  bool hidePassword = true;

  /*
  -------------------------
  RESET PASSWORD
  -------------------------
  */

  Future<void> resetPassword() async {

    if(passwordController.text.length < 6){
      showMessage("Password must be at least 6 characters");
      return;
    }

    if(passwordController.text != confirmController.text){
      showMessage("Passwords do not match");
      return;
    }

    setState(() {
      loading = true;
    });

    try{

      final data = await ApiClient.post(
        ApiEndpoints.resetPassword,
        {
          "identity": widget.identity,
          "password": passwordController.text
        },
      );

      if(data["status"] == true){

        showMessage("Password updated successfully");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
              (route) => false,
        );

      }else{

        showMessage(data["message"] ?? "Failed to reset password");

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
  SHOW MESSAGE
  -------------------------
  */

  void showMessage(String msg){
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: const Color(0xff221011),

      body: SafeArea(

        child: Center(

          child: SingleChildScrollView(

            child: Container(

              width: width > 500 ? 420 : double.infinity,
              padding: const EdgeInsets.all(24),

              child: Column(

                children: [

                  /// BACK BUTTON
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,color: Colors.white),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ICON
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock,
                      size: 60,
                      color: Colors.red,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Reset Password",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Create a new secure password",
                    style: TextStyle(color: Colors.white60),
                  ),

                  const SizedBox(height: 30),

                  /// PASSWORD
                  TextField(
                    controller: passwordController,
                    obscureText: hidePassword,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: "New Password",
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xff1E1E1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// CONFIRM PASSWORD
                  TextField(
                    controller: confirmController,
                    obscureText: hidePassword,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: "Confirm Password",
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xff1E1E1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// BUTTON
                  GestureDetector(
                    onTap: loading ? null : resetPassword,
                    child: Container(

                      height: 54,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: Center(
                        child: loading
                            ? const CircularProgressIndicator(
                            color: Colors.white)
                            : const Text(
                          "Reset Password",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}