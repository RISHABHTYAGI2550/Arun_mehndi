import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course_model.dart';

class CourseService {
  static const String baseUrl = "https://api.aktuhub.in/api";

  // ✅ Level mapping
  static String mapLevel(String level) {
    switch (level) {
      case "Beginner":
        return "basic";
      case "Intermediate":
        return "medium";
      case "Pro":
        return "advanced";
      default:
        return level.toLowerCase();
    }
  }

  // ✅ Category mapping — UI label → API value
  static String mapCategory(String category) {
    switch (category.toLowerCase()) {
      case "mehndi":
        return "mehndi";
      case "beauty":
        return "beauty";
      case "makeup":
        return "makeup";
      case "nail art":
        return "nail_art"; // ✅ space → underscore (common API pattern)
      default:
        return category.toLowerCase();
    }
  }

  static Future<List<Course>> getCourses({
    required String token,
    String? category,
    String? level,
    String? search,
    int page = 1,
  }) async {
    final queryParams = <String, String>{
      "page": page.toString(),
    };

    if (category != null && category.isNotEmpty) {
      queryParams["category"] = mapCategory(category); // ✅ mapping use karo
    }

    if (level != null && level.isNotEmpty) {
      queryParams["level"] = mapLevel(level);
    }

    if (search != null && search.isNotEmpty) {
      queryParams["search"] = search;
    }

    final uri =
    Uri.parse("$baseUrl/courses").replace(queryParameters: queryParams);

    // ✅ Debug — dekho kya ja raha hai API ko

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );


    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final list = decoded['data'] as List? ?? [];
      return list.map((e) => Course.fromJson(e)).toList();
    } else {
      throw Exception("API ERROR: ${response.statusCode}");
    }
  }
}