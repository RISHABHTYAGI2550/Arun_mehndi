import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'certificate_screen.dart';

class LiveIntroScreen extends StatefulWidget {
  const LiveIntroScreen({super.key});

  @override
  State<LiveIntroScreen> createState() => _LiveIntroScreenState();
}

class _LiveIntroScreenState extends State<LiveIntroScreen>
    with TickerProviderStateMixin {

  late AnimationController bubble1Controller;
  late AnimationController bubble2Controller;

  late Animation<Offset> bubble1Animation;
  late Animation<Offset> bubble2Animation;

  @override
  void initState() {
    super.initState();

    bubble1Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    bubble2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    bubble1Animation =
        Tween(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: bubble1Controller, curve: Curves.easeOut),
        );

    bubble2Animation =
        Tween(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: bubble2Controller, curve: Curves.easeOut),
        );

    Future.delayed(const Duration(milliseconds: 200), () {
      bubble1Controller.forward();
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      bubble2Controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Column(
          children: [

            /// Top Skip
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Skip",
                  style: AppTextStyles.small.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// Phone Mockup Section
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    /// Gold Glow
                    Positioned(
                      left: -40,
                      child: Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          color: AppColors.gold.withOpacity(.15),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    /// Red Glow
                    Positioned(
                      right: -40,
                      bottom: 40,
                      child: Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    /// Phone Frame
                    Container(
                      width: 260,
                      height: 520,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.grey.shade300, width: 5),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 30,
                            color: Colors.black12,
                          )
                        ],
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),

                        child: Stack(
                          children: [

                            /// Video Image
                            Positioned.fill(
                              child: Image.asset(
                                "assets/images/live_class.png", fit: BoxFit.cover,
                              ),
                            ),

                            /// Dark Overlay
                            Positioned.fill(
                              child: Container(
                                color: Colors.black.withOpacity(.25),
                              ),
                            ),

                            /// LIVE badge
                            Positioned(
                              top: 20,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.circle,
                                        size: 8, color: Colors.white),
                                    SizedBox(width: 6),
                                    Text(
                                      "LIVE",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// Viewers
                            Positioned(
                              top: 20,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.visibility,
                                        size: 14, color: Colors.white),
                                    SizedBox(width: 4),
                                    Text(
                                      "1.2k",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// Chat bubbles
                            Positioned(
                              bottom: 80,
                              left: 12,
                              right: 12,
                              child: Column(
                                children: [

                                  SlideTransition(
                                    position: bubble1Animation,
                                    child: chatBubble(
                                        "Meera", "Wow, that stroke is so clean!"),
                                  ),

                                  const SizedBox(height: 8),

                                  SlideTransition(
                                    position: bubble2Animation,
                                    child: chatBubble(
                                        "Anjali", "Sir, which brush size is this?"),
                                  ),

                                ],
                              ),
                            ),

                            /// Message box
                            Positioned(
                              bottom: 16,
                              left: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Say something...",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white70),
                                    ),
                                    Spacer(),
                                    Icon(Icons.send,
                                        size: 16, color: Colors.white70)
                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Bottom Text Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTextStyles.title.copyWith(color: Colors.white),
                      children: const [
                        TextSpan(text: "Interactive "),
                        TextSpan(
                            text: "Live Classes",
                            style: TextStyle(color: AppColors.gold)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Ask questions in real-time and learn directly from Arun Sir and expert instructors.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(height: 24),

                  /// Progress dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      dot(false),
                      const SizedBox(width: 6),
                      dot(true),
                      const SizedBox(width: 6),
                      dot(false),

                    ],
                  ),

                  const SizedBox(height: 24),

                  /// Next Button
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CertificateIntroScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(.3),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Next",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget chatBubble(String name, String message) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: AppColors.gold.withOpacity(.5),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "$name: $message",
              style: const TextStyle(fontSize: 11, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: active ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? AppColors.primary : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}