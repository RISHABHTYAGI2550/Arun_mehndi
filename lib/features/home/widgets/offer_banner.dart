import 'package:flutter/material.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.all(16),

      padding: const EdgeInsets.all(16),
width: 1000,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(16),

      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "SPECIAL OFFER",
              style: TextStyle(color: Colors.white,fontSize: 10),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Bridal Mehndi Masterclass",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Learn advanced techniques with Arun",
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),

            child: const Text(
              "Enroll Now - 30% Off",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}