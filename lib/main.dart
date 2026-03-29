import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/onboarding/splash_screen.dart';
import 'features/auth/auth_provider.dart';

void main() {
  runApp(const MehndiApp());
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