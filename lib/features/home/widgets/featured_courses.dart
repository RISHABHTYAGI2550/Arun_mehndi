import 'package:flutter/material.dart';

class FeaturedCourses extends StatelessWidget {
  const FeaturedCourses({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Featured Courses",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              Text("See All",style: TextStyle(color: Colors.red))
            ],
          ),

          const SizedBox(height: 16),

          SizedBox(
            height: 210,

            child: ListView(
              scrollDirection: Axis.horizontal,

              children: const [

                CourseCard(),

                SizedBox(width: 16),

                CourseCard()

              ],
            ),
          )
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(

      width: 160,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(

        children: [

          Container(
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/200"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Bridal Mehndi Masterclass",maxLines: 2),

                SizedBox(height: 4),

                Text("₹999",style: TextStyle(color: Colors.red))
              ],
            ),
          )
        ],
      ),
    );
  }
}