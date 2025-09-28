import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF31A0D0);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212); // Better dark mode background
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFF6F6F6);
  static const Color lightGrey = Color(0xFFE8E8E8);
  static const Color darkGrey = Color(0xFFBDBDBD);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      foregroundColor: black,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: black),
      titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: primary),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: primary),
      bodyLarge: TextStyle(color: black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, // Ensure it's set as dark mode
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundDark, // Background is now dark
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,

    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),
    cardColor: Colors.grey[900], // Ensure cards have a dark background
  );

}
