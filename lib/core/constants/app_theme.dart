import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';


class AppTheme {

  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,

    primaryColor: AppColors.primary,

    scaffoldBackgroundColor: AppColors.backgroundDark,

    fontFamily: AppFonts.body,


    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),

  );
}