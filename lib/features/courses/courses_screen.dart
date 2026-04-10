import 'package:flutter/material.dart';

import '../home/widgets/featured_courses.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF8F8F5),

      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,

        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black),

        title: const Text(
          "All Professional Courses",
          style: TextStyle(color: Colors.black),
        ),

        centerTitle: true,

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications, color: Colors.black),
          )
        ],
      ),

      body: Column(

        children: [

          /// SEARCH + FILTER
          Padding(
            padding: const EdgeInsets.all(16),

            child: Row(
              children: [

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),

                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: "Search masterclasses...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.tune, color: Colors.black),
                )

              ],
            ),
          ),

          /// CATEGORY CHIPS
          SizedBox(
            height: 40,

            child: ListView(
              scrollDirection: Axis.horizontal,

              padding: const EdgeInsets.symmetric(horizontal: 16),

              children: [

                chip("All", true),
                chip("Mehndi", false),
                chip("Nail Art", false),
                chip("Beauty", false),
                chip("Bridal", false),

              ],
            ),
          ),

          const SizedBox(height: 10),

          /// COURSE LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),

              children: const [

                CourseCard(
                  title: "Advance Bridal Mehndi Masterclass",
                  price: "₹4,999",
                  oldPrice: "₹8,999",
                  rating: "4.9",
                  students: "1.2k Students",
                  image: "https://picsum.photos/400/200",
                  badge: "Bestseller",
                ),

                SizedBox(height: 16),

                CourseCard(
                  title: "Pro Nail Art & Extension Course",
                  price: "₹2,999",
                  oldPrice: "₹6,499",
                  rating: "4.7",
                  students: "850 Students",
                  image: "https://picsum.photos/401/200", badge: '',
                ),

                SizedBox(height: 16),

                CourseCard(
                  title: "Complete Bridal Makeup Artistry",
                  price: "₹7,999",
                  oldPrice: "₹12,000",
                  rating: "4.8",
                  students: "2.1k Students",
                  image: "https://picsum.photos/402/200", badge: '',
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget chip(String text, bool active){

    return Container(
      margin: const EdgeInsets.only(right: 10),

      padding: const EdgeInsets.symmetric(horizontal: 14),

      decoration: BoxDecoration(
        color: active ? Colors.amber : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: active ? Colors.black : Colors.black54,
          ),
        ),
      ),
    );
  }
}