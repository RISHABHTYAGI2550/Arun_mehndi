import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

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
              Text("Categories",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              Text("See All",style: TextStyle(color: Colors.red))
            ],
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [

              CategoryItem("Mehndi","🖌️"),
              CategoryItem("Nail Art","💅"),
              CategoryItem("Makeup","💄"),
              CategoryItem("Beauty","✨")

            ],
          )
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {

  final String title;
  final String icon;

  const CategoryItem(this.title,this.icon,{super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        CircleAvatar(
          radius: 26,
          child: Text(icon),
        ),

        const SizedBox(height: 6),

        Text(title)
      ],
    );
  }
}