import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/theme/app_colors.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.brandColor,
    scaffoldBackgroundColor: AppColors.lBody,
    colorScheme: const ColorScheme.light(
      primary: AppColors.brandColor,
      secondary: AppColors.brandSecondary,
      surface: AppColors.lSurface,
      onPrimary: Colors.white,
      onSurface: AppColors.lTextPrimary,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.lTextPrimary,
      displayColor: AppColors.lTextPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.brandColor,
    scaffoldBackgroundColor: AppColors.dBody,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.brandColor,
      secondary: AppColors.brandColor,
      surface: AppColors.dSurface,
      onPrimary: Colors.white,
      onSurface: AppColors.dTextPrimary,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.dTextPrimary,
      displayColor: AppColors.dTextPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
