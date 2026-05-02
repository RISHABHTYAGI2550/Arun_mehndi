import 'dart:async';
import 'package:flutter/material.dart';

import '../../../core/helpers/storage_helper.dart';
import '../models/course_model.dart';
import '../services/course_service.dart';
import '../widgets/course_card.dart';
import '../shimmer/course_card_shimmer.dart';
import '../widgets/filter_bottom_sheet.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<Course> courses = [];

  int page = 1;
  bool isLoading = true;
  bool hasMore = true;

  String selectedCategory = "All";
  String? selectedLevel;
  String search = "";

  String token = "";

  final ScrollController controller = ScrollController();
  Timer? debounce;

  List<String> categories = ["All", "Mehndi", "Beauty", "Makeup", "Nail Art"];

  @override
  void initState() {
    super.initState();
    init();

    controller.addListener(() {
      if (controller.position.pixels ==
          controller.position.maxScrollExtent &&
          hasMore) {
        loadMore();
      }
    });
  }

  // 🔥 INIT
  Future<void> init() async {
    token = await StorageHelper.getToken() ?? "";
    fetchCourses();
  }

  // 🔥 FETCH COURSES (FINAL FIXED)
  Future<void> fetchCourses() async {
    setState(() {
      isLoading = true;
      page = 1;
      hasMore = true;
    });

    try {
      final data = await CourseService.getCourses(
        token: token,

        // 🔥 IMPORTANT FIX (Search priority)
        category: search.isEmpty
            ? (selectedCategory == "All" ? null : selectedCategory)
            : null,

        level: selectedLevel,

        search: search.trim().isEmpty ? null : search.trim(),

        page: page,
      );

      courses = data;

      if (data.isEmpty) hasMore = false;
    } catch (e) {
      print("❌ ERROR: $e");
    }

    setState(() => isLoading = false);
  }

  // 🔥 PAGINATION
  Future<void> loadMore() async {
    page++;

    final data = await CourseService.getCourses(
      token: token,
      category: selectedCategory == "All" ? null : selectedCategory,
      level: selectedLevel,
      search: search.trim().isEmpty ? null : search.trim(),
      page: page,
    );

    if (data.isEmpty) {
      hasMore = false;
    } else {
      courses.addAll(data);
    }

    setState(() {});
  }

  // 🔥 FILTER POPUP
  void openFilter() {
    showModalBottomSheet(
      context: context,
      builder: (_) => FilterBottomSheet(
        onApply: (level) {
          setState(() {
            selectedLevel = level;
            search = ""; // reset search
          });

          fetchCourses();
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
      ),
      body: Column(
        children: [
          // 🔍 SEARCH
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration:
                    const InputDecoration(hintText: "Search courses..."),
                    onChanged: (val) {
                      if (debounce?.isActive ?? false) debounce!.cancel();

                      debounce =
                          Timer(const Duration(milliseconds: 400), () {
                            setState(() {
                              search = val;

                              // 🔥 reset filters
                              selectedCategory = "All";
                              selectedLevel = null;
                            });

                            fetchCourses();
                          });
                    },
                  ),
                ),
                IconButton(
                  onPressed: openFilter,
                  icon: const Icon(Icons.filter_list),
                )
              ],
            ),
          ),

          // 🏷 CATEGORY
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final cat = categories[i];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = cat;
                      search = "";
                    });

                    fetchCourses();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Chip(
                      label: Text(cat),
                      backgroundColor: selectedCategory == cat
                          ? Colors.red
                          : Colors.grey.shade200,
                    ),
                  ),
                );
              },
            ),
          ),

          // 📦 COURSE LIST
          Expanded(
            child: isLoading
                ? ListView.builder(
              itemCount: 5,
              itemBuilder: (_, __) => const CourseCardShimmer(),
            )
                : courses.isEmpty
                ? const Center(child: Text("No courses found"))
                : ListView.builder(
              controller: controller,
              itemCount: courses.length,
              itemBuilder: (_, i) {
                return CourseCard(course: courses[i]);
              },
            ),
          )
        ],
      ),
    );
  }
}