import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'features/courses/screens/courses_screen.dart';
import 'features/courses/learning_screen.dart';
import 'features/courses/profile_screen.dart';
import 'features/home/home_screen.dart';
import 'widgets/side_drawer.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {

  int currentIndex = 0;

  final screens = const [
    HomeScreen(),
    CoursesScreen(),
    LearningScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      drawer: const SideDrawer(),

      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      bottomNavigationBar: ConvexAppBar(

        style: TabStyle.reactCircle,

        backgroundColor: const Color(0xFF1A1405),

        activeColor: Colors.amber,

        color: Colors.white70,

        items: const [

          TabItem(icon: Icons.home,title: "Home"),

          TabItem(icon: Icons.menu_book,title: "Courses"),

          TabItem(icon: Icons.play_circle,title: "Learning"),

          TabItem(icon: Icons.person,title: "Profile"),

        ],

        initialActiveIndex: currentIndex,

        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}