class UserModel {

  final String name;
  final String email;
  final String? profileImage;

  UserModel({
    required this.name,
    required this.email,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {

    return UserModel(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "profile_image": profileImage,
    };
  }
}