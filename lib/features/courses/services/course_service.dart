import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course_model.dart';

class CourseService {
  static const String baseUrl = "https://api.aktuhub.in/api";

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

  static Future<List<Course>> getCourses({
    required String token,
    String? category,
    String? level,
    String? search,
    int page = 1,
  }) async {
    final queryParams = {
      "page": page.toString(),
    };

    if (category != null) {
      queryParams["category"] = category.toLowerCase();
    }

    if (level != null) {
      queryParams["level"] = mapLevel(level);
    }

    if (search != null && search.isNotEmpty) {
      queryParams["search"] = search;
    }

    final uri = Uri.parse("$baseUrl/courses")
        .replace(queryParameters: queryParams);

    print("👉 URL: $uri");

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token", // ✅ FIX
        "Accept": "application/json",
      },
    );

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return (decoded['data'] as List)
          .map((e) => Course.fromJson(e))
          .toList();
    } else {
      throw Exception("API ERROR");
    }
  }
}