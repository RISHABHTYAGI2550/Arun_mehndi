import 'package:flutter/material.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Arun Mehndi App"),
      ),

      body: const Center(
        child: Text(
          "learnin",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}