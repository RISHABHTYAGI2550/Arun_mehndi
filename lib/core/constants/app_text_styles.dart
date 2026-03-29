import 'package:flutter/material.dart';
import 'app_fonts.dart';

class AppTextStyles {

  static const heading = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.2,
  );

  static const title = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const body = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 16,
    color: Colors.white70,
  );

  static const small = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 12,
    color: Colors.white60,
  );

}