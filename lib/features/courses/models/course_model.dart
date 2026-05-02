class Course {
  final int id;
  final String title;
  final String thumbnail;
  final String price;
  final String level;
  final String category;
  final String description;

  Course({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.level,
    required this.category,
    required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: int.tryParse(json['id'].toString()) ?? 0, // ✅ FIX
      title: json['title'] ?? "",
      thumbnail: json['thumbnail'] ?? "",
      price: json['price'].toString(),
      level: json['level'] ?? "",
      category: json['category'] ?? "",
      description: json['description'] ?? "",
    );
  }
}