import 'dart:ui';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      child: AnimatedBuilder(
        animation: animation,

        builder: (context, child) {

          return Transform.scale(
            scale: 1 + (animation.value * 0.03),

            child: ClipRRect(

              borderRadius: BorderRadius.circular(18),

              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),

                child: Container(

                  decoration: BoxDecoration(

                    color: Colors.white.withOpacity(0.25),

                    borderRadius: BorderRadius.circular(18),

                    border: Border.all(
                      color: Colors.white.withOpacity(0.6),
                      width: 1.3,
                    ),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.15 + animation.value * 0.1),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      )

                    ],
                  ),

                  child: TextField(

                    focusNode: focusNode,

                    decoration: InputDecoration(

                      hintText: "Search Mehndi courses...",

                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(.6),
                      ),

                      prefixIcon: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.search,
                          color: animation.value > 0.5
                              ? Colors.black
                              : Colors.black54,
                        ),
                      ),

                      border: InputBorder.none,

                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}