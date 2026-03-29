import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Arun Mehndi App"),
      ),

      body: const Center(
        child: Text(
          "course",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}