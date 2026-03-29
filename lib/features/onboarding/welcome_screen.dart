import 'package:flutter/material.dart';
import 'package:mehndi_student_app/features/onboarding/live_intro_screen.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          /// Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/mehndi_bg.png",
              fit: BoxFit.cover,
            ),
          ),

          /// Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.2),
                    Color.fromRGBO(0, 0, 0, 0.85),
                  ],
                ),
              ),
            ),
          ),

          /// Main Content
          SafeArea(
            child: Column(
              children: [

                /// Logo Glass Card
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Image.asset(
                        "assets/images/splash_logo.jpeg",
                        height: 60,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                /// Text Section Animation
                FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(

                        children: [

                          Text(
                            "Master the Art\nof Mehndi",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.heading,
                          ),

                          const SizedBox(height: 20),

                          Text(
                            "Learn from the best with professional courses designed for all skill levels.",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body,
                          ),

                          const SizedBox(height: 30),

                          /// Progress Dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Container(
                                width: 30,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              const SizedBox(width: 6),

                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.white30,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              const SizedBox(width: 6),

                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.white30,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                            ],
                          ),

                          const SizedBox(height: 30),

                          /// Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Skip",
                                  style: TextStyle(
                                    color: Colors.white60,
                                  ),
                                ),
                              ),

                              ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 16),
                                  shape: const StadiumBorder(),
                                  elevation: 8,
                                ),

                                onPressed: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LiveIntroScreen(),
                                    ),
                                  );
                                },

                                child: const Row(
                                  children: [
                                    Text("Next", style: TextStyle(color: Colors.white),),
                                    SizedBox(width: 6),
                                    Icon(Icons.arrow_forward, color: Colors.white,)
                                  ],
                                ),

                              )

                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// Bottom Indicator
                Container(
                  width: 120,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 12),

              ],
            ),
          ),

        ],
      ),
    );
  }
}