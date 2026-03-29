class ApiEndpoints {

  /*
  -------------------------
  BASE URL
  -------------------------
  */

  static const String baseUrl = "https://api.aktuhub.in/api";

  /*
  -------------------------
  AUTH
  -------------------------
  */

  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String verifyOtp = "/auth/verify-otp";

  /*
  -------------------------
  COURSES
  -------------------------
  */

  static const String courses = "/courses";
  static const String courseDetail = "/course-detail";

  /*
  -------------------------
  LESSONS
  -------------------------
  */

  static const String lessonVideo = "/lesson-video";

  /*
  -------------------------
  STUDENT
  -------------------------
  */

  static const String dashboard = "/student-dashboard";
  static const String progress = "/progress";

  /*
  -------------------------
  REVIEWS
  -------------------------
  */

  static const String reviews = "/reviews";

  /*
  -------------------------
  CERTIFICATE
  -------------------------
  */

  static const String certificate = "/certificate";

  /*
  -------------------------
  NOTIFICATIONS
  -------------------------
  */

  static const String notifications = "/notifications";

  /*
  -------------------------
  LIVE CLASSES
  -------------------------
  */

  static const String live = "/live";

  static const forgotPassword = "/auth/forgot-password";
  static const verifyResetOtp = "/auth/verify-reset-otp";
  static const resetPassword = "/auth/reset-password";

}