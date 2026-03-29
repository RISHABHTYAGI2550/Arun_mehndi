import 'package:flutter/material.dart';

class UpcomingLiveClass extends StatelessWidget {
  const UpcomingLiveClass({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.all(16),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: const [

              Text(
                "Arabic Mehndi Fusion",
                style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 6),

              Text(
                "With Arun Mehndi Studio",
                style: TextStyle(color: Colors.white70),
              )
            ],
          ),

          ElevatedButton(
            onPressed: () {},
            child: const Text("Join Class"),
          )
        ],
      ),
    );
  }
}