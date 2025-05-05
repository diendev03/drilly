import 'package:flutter/material.dart';
import '../utils/color_res.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorRes.primary,
    scaffoldBackgroundColor: ColorRes.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorRes.primary,
      foregroundColor: ColorRes.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: ColorRes.black),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorRes.accent,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorRes.black,
      foregroundColor: ColorRes.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: ColorRes.primary,
      secondary: ColorRes.accent,
    ),
  );
}
