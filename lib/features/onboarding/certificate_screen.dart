import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../auth/create_account_screen.dart';

class CertificateIntroScreen extends StatefulWidget {
  const CertificateIntroScreen({super.key});

  @override
  State<CertificateIntroScreen> createState() =>
      _CertificateIntroScreenState();
}

class _CertificateIntroScreenState extends State<CertificateIntroScreen>
    with TickerProviderStateMixin {

  late AnimationController cardController;
  late Animation<double> rotateAnim;

  @override
  void initState() {
    super.initState();

    cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    rotateAnim = Tween(begin: -0.1, end: 0.0).animate(
      CurvedAnimation(parent: cardController, curve: Curves.easeOut),
    );

    cardController.forward();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [

            /// Skip
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

            /// Illustration Section
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    /// Gold glow
                    Container(
                      width: 260,
                      height: 280,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(.15),
                        shape: BoxShape.circle,
                      ),
                    ),

                    /// Certificate Card
                    AnimatedBuilder(
                      animation: rotateAnim,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: rotateAnim.value,
                          child: child,
                        );
                      },

                      child: Container(
                        width: 180,
                        height: 130,
                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 20,
                              color: Colors.black12,
                            )
                          ],
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.workspace_premium,
                                color: AppColors.primary,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Container(
                              height: 6,
                              width: 100,
                              color: Colors.grey.shade200,
                            ),

                            const SizedBox(height: 6),

                            Container(
                              height: 4,
                              width: 60,
                              color: Colors.grey.shade200,
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Earnings Card
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        width: 200,
                        height: 140,
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 20,
                              color: Colors.black12,
                            )
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: const [
                                Icon(Icons.trending_up,
                                    color: Colors.green, size: 16),
                                SizedBox(width: 6),
                                Text(
                                  "Earnings Growth",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            const Spacer(),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                bar(20),
                                bar(40),
                                bar(60),
                                bar(80),

                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            /// Text Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTextStyles.heading.copyWith(
                        color: Colors.black,
                      ),
                      children: const [
                        TextSpan(text: "Get Certified &\n"),
                        TextSpan(
                          text: "Start Earning",
                          style: TextStyle(color: AppColors.gold),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    "Turn your passion into a professional career with our recognized certifications.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 30),

                ],
              ),
            ),

            /// Bottom Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [

                  /// Progress dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      dot(false),
                      const SizedBox(width: 6),
                      dot(false),
                      const SizedBox(width: 6),
                      dot(true),

                    ],
                  ),

                  const SizedBox(height: 24),

                  /// Button
                  GestureDetector(
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateAccountScreen(),
                        ),
                      );

                    },

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
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Get Started",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bar(double height) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        height: height,
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(3),
        ),
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