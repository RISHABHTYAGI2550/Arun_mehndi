import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {

  final String text;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        width: double.infinity,
        height: 56,

        decoration: BoxDecoration(

          color: AppColors.primary,

          borderRadius: BorderRadius.circular(30),

          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 8),

            const Icon(Icons.arrow_forward, color: Colors.white)

          ],
        ),

      ),
    );
  }
}