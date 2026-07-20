import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.smokyBlack,
      primaryColor: AppColors.orangeYellow,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.orangeYellow,
        secondary: AppColors.orangeYellow,
        surface: AppColors.eerieBlack2,
        onSurface: AppColors.white2,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: AppColors.lightGray,
        displayColor: AppColors.white2,
      ),
      iconTheme: const IconThemeData(color: AppColors.lightGray70, size: 18),
    );
  }
}
