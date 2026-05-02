import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'features/onboarding/splash_screen.dart';
import 'features/auth/auth_provider.dart';

void main() {
  runApp(const MehndiApp());
  testApi();
}

class MehndiApp extends StatelessWidget {

  const MehndiApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

      ],

      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),

    );

  }
}



void testApi() async {
  String token = "PASTE_YOUR_TOKEN_HERE";

  final response = await http.get(
    Uri.parse("https://api.aktuhub.in/api/courses"),
    headers: {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
    },
  );

  print("STATUS: ${response.statusCode}");
  print("BODY: ${response.body}");
}