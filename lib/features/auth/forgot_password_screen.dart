import 'package:flutter/material.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import 'otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final TextEditingController identityController = TextEditingController();

  bool loading = false;

  /*
  -------------------------
  SEND RESET
  -------------------------
  */

  Future<void> sendReset() async {

    if(identityController.text.trim().isEmpty){
      showMessage("Enter email or phone number");
      return;
    }

    setState(() {
      loading = true;
    });

    try{

      final data = await ApiClient.post(
        "/auth/forgot-password",
        {
          "identity": identityController.text.trim()
        },
      );

      if(data["status"] == true){

        showMessage("Reset code sent");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VerifyResetOtpScreen(
              identity: identityController.text.trim(),
            ),
          ),
        );

      }else{

        showMessage(data["message"] ?? "Failed to send reset code");

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
    identityController.dispose();
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

                  /// Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,color: Colors.white),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// LOGO
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_reset,
                      size: 70,
                      color: Colors.red,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Enter your registered email or phone number. We will send an OTP to reset password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white60),
                  ),

                  const SizedBox(height: 30),

                  /// INPUT
                  TextField(
                    controller: identityController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: "Email or phone",
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
                    onTap: loading ? null : sendReset,
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
                            : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send Reset Code",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.send,color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "Need more help? Contact Support",
                    style: TextStyle(color: Colors.white54),
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