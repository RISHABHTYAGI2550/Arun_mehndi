import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AnimatedProgressBar extends StatefulWidget {

  const AnimatedProgressBar({super.key});

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      width: 180,
      height: 4,

      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),

      child: AnimatedBuilder(

        animation: controller,

        builder: (_, __) {

          return FractionallySizedBox(

            alignment: Alignment.centerLeft,

            widthFactor: controller.value,

            child: Container(
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

          );

        },
      ),
    );
  }
}