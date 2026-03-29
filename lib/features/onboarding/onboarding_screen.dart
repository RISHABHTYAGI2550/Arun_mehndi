import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {

const OnboardingScreen({super.key});

@override
State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

final PageController _controller = PageController();

int currentPage = 0;

void nextPage() {

if (currentPage < 3) {

_controller.nextPage(
duration: const Duration(milliseconds: 400),
curve: Curves.easeInOut,
);

}

}

@override
Widget build(BuildContext context) {

return Scaffold(

body: Stack(

children: [

PageView(

controller: _controller,

onPageChanged: (index) {

setState(() {
currentPage = index;
});

},

children: const [

PageOne(),
PageTwo(),
PageThree(),
PageFour(),

],

),

Positioned(
bottom: 40,
left: 20,
right: 20,
child: ElevatedButton(

onPressed: nextPage,

child: Text(
currentPage == 3 ? "Get Started" : "Next",
),

),
)

],

),

);
}
}

class PageOne extends StatelessWidget {

  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {

    return const Center(
      child: Text(
        "Welcome to Arun Mehndi",
        style: TextStyle(fontSize: 28),
      ),
    );

  }

}
class PageTwo extends StatelessWidget {

  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {

    return const Center(
      child: Text(
        "Interactive Live Classes",
        style: TextStyle(fontSize: 28),
      ),
    );

  }

}
class PageThree extends StatelessWidget {

  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {

    return const Center(
      child: Text(
        "Get Certified",
        style: TextStyle(fontSize: 28),
      ),
    );

  }

}
class PageFour extends StatelessWidget {

  const PageFour({super.key});

  @override
  Widget build(BuildContext context) {

    return const Center(
      child: Text(
        "Start Learning Today",
        style: TextStyle(fontSize: 28),
      ),
    );

  }

}