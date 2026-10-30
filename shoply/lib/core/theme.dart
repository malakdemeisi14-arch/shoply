import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF0B5D3B);
  static const soft = Color(0xFFE6F2EC);
  static const field = Color(0xFFF3F4F3);
  static const text = Color(0xFF1B1B1B);
  static const grey = Color(0xFF8A8F8C);
  static const danger = Color(0xFFE53935);
}

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      foregroundColor: AppColors.text,
      titleTextStyle: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      ),
    ),
  );
}
