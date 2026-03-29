import 'package:flutter/material.dart';
import 'package:mehndi_student_app/features/home/home_screen.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/main_layout.dart';
import 'auth_provider.dart';
import 'login_screen.dart';
import '../../core/services/user_storage.dart';
import '../../models/user_model.dart';

void onAuthSuccess(Map<String,dynamic> response) async {

    UserModel user = UserModel.fromJson(response["user"]);

    String token = response["token"];

    await UserStorage.saveUser(user);
    await UserStorage.saveToken(token);

}

class CreateAccountScreen extends StatefulWidget {
    const CreateAccountScreen({super.key});

    @override
    State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {

    final _formKey = GlobalKey<FormState>();

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    bool loading = false;

    Future<void> register() async {

        print("REGISTER BUTTON CLICKED");

        setState(() {
            loading = true;
        });

        try {

            bool success = await context.read<AuthProvider>().registerUser(
                nameController.text.trim(),
                emailController.text.trim(),
                phoneController.text.trim(),
                passwordController.text.trim(),
            );

            print("REGISTER RESULT: $success");

            if(success){

                print("REGISTER SUCCESS");

                if(!mounted) return;

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MainNavigationScreen(),
                    ),
                        (route) => false,
                );

            } else {

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Account creation failed"),
                    ),
                );

            }

        } catch(e){

            print("REGISTER ERROR: $e");

            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Server error. Please try again."),
                ),
            );

        }

        if(mounted){
            setState(() {
                loading = false;
            });
        }

    }

    @override
    void dispose() {
        nameController.dispose();
        emailController.dispose();
        phoneController.dispose();
        passwordController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(

            backgroundColor: const Color(0xFF0F0F0F),

            body: SafeArea(

                child: SingleChildScrollView(

                    padding: const EdgeInsets.all(24),

                    child: Form(

                        key: _formKey,

                        child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                                const SizedBox(height: 30),

                                Center(
                                    child: Image.asset(
                                        "assets/images/splash_logo.jpeg",
                                        height: 80,
                                    ),
                                ),

                                const SizedBox(height: 30),

                                Text(
                                    "Create Account",
                                    style: AppTextStyles.heading,
                                ),

                                const SizedBox(height: 8),

                                Text(
                                    "Start learning Mehndi like a professional",
                                    style: AppTextStyles.body,
                                ),

                                const SizedBox(height: 40),

                                inputField("Full Name", Icons.person, nameController),

                                const SizedBox(height: 16),

                                inputField("Email", Icons.email, emailController),

                                const SizedBox(height: 16),

                                inputField("Mobile Number", Icons.phone, phoneController),

                                const SizedBox(height: 16),

                                inputField(
                                    "Password",
                                    Icons.lock,
                                    passwordController,
                                    isPassword: true,
                                ),

                                const SizedBox(height: 30),

                                GestureDetector(
                                    onTap: loading ? null : register,
                                    child: Container(

                                        height: 52,
                                        width: double.infinity,

                                        decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(14),
                                            boxShadow: [
                                                BoxShadow(
                                                    color: AppColors.primary.withOpacity(.4),
                                                    blurRadius: 20,
                                                )
                                            ],
                                        ),

                                        child: Center(
                                            child: loading
                                                ? const CircularProgressIndicator(color: Colors.white)
                                                : const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                    Text(
                                                        "Create Account",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Icon(Icons.arrow_forward, color: Colors.white)
                                                ],
                                            ),
                                        ),
                                    ),
                                ),

                                const SizedBox(height: 20),

                                Center(
                                    child: GestureDetector(
                                        onTap: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => const LoginScreen(),
                                                ),
                                            );
                                        },
                                        child: const Text(
                                            "Already have an account? Login",
                                            style: TextStyle(color: Colors.white70),
                                        ),
                                    ),
                                ),

                            ],
                        ),
                    ),
                ),
            ),
        );
    }

    Widget inputField(
        String hint,
        IconData icon,
        TextEditingController controller,
        {bool isPassword = false}
        ){

        return TextFormField(

            controller: controller,
            obscureText: isPassword,

            style: const TextStyle(color: Colors.white),

            decoration: InputDecoration(

                prefixIcon: Icon(icon, color: Colors.white54),

                hintText: hint,
                hintStyle: const TextStyle(color: Colors.white38),

                filled: true,
                fillColor: const Color(0xFF1E1E1E),

                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                ),
            ),
        );
    }
}