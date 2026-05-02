import 'package:flutter/material.dart';

import '../features/home/home_screen.dart';
import '../features/courses/screens/courses_screen.dart';
import '../features/courses/learning_screen.dart';
import '../features/courses/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {

  int currentIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = const [
      HomeScreen(),
      CoursesScreen(),
      LearningScreen(),
      ProfileScreen(),
    ];
  }

  void changeTab(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,
        onTap: changeTab,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,

        backgroundColor: Colors.white,

        elevation: 8,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: "Courses",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            activeIcon: Icon(Icons.play_circle),
            label: "My Learning",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),

        ],
      ),
    );
  }
}