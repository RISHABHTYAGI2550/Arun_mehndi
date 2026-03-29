import 'package:flutter/material.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import 'reset_password_screen.dart';

class VerifyResetOtpScreen extends StatefulWidget {

  final String identity;

  const VerifyResetOtpScreen({super.key, required this.identity});

  @override
  State<VerifyResetOtpScreen> createState() => _VerifyResetOtpScreenState();
}

class _VerifyResetOtpScreenState extends State<VerifyResetOtpScreen> {

  final otpController = TextEditingController();

  bool loading = false;

  /*
  -------------------------
  VERIFY OTP
  -------------------------
  */

  Future<void> verifyOtp() async {

    if(otpController.text.trim().isEmpty){
      showMessage("Enter OTP");
      return;
    }

    if(otpController.text.trim().length < 4){
      showMessage("Invalid OTP");
      return;
    }

    setState(() {
      loading = true;
    });

    try{

      final data = await ApiClient.post(
        ApiEndpoints.verifyResetOtp,
        {
          "identity": widget.identity,
          "otp": otpController.text.trim()
        },
      );

      print("VERIFY OTP RESPONSE: $data");

      if(data["status"] == true){

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(
              identity: widget.identity,
            ),
          ),
        );

      }else{

        showMessage(data["message"] ?? "OTP verification failed");

      }

    }catch(e){

      print("OTP ERROR: $e");

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
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xff221011),

      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "Verify OTP",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),

                decoration: InputDecoration(
                  hintText: "Enter OTP",
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: const Color(0xff1E1E1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(

                  onPressed: loading ? null : verifyOtp,

                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Verify OTP"),

                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}