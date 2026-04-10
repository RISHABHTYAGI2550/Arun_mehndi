import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {

  final String title;
  final String price;
  final String oldPrice;
  final String rating;
  final String students;
  final String image;
  final String? badge;

  const CourseCard({
    super.key,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.students,
    required this.image,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
          )
        ],
      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          /// IMAGE
          Stack(
            children: [

              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18)),
                child: Image.network(
                  image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              if(badge != null)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    color: Colors.black87,
                    child: Text(
                      badge!,
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 10,
                      ),
                    ),
                  ),
                )

            ],
          ),

          /// CONTENT
          Padding(
            padding: const EdgeInsets.all(14),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(" $rating"),
                    const Text(" • "),
                    Text(students),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          oldPrice,
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {},
                      child: const Text("Enroll"),
                    )

                  ],
                )

              ],
            ),
          )

        ],
      ),
    );
  }
}