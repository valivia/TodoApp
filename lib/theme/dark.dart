import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  fontFamily: "Quicksand",
  scaffoldBackgroundColor: const Color(0xFF212121),
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Color(0xFF1db954),
    secondary: Color(0xFF1db954),
    // Background
    background: Color(0xFF212121),
    onBackground: Color(0xFFb3b3b3),
    // Surface
    surface: Color(0xFF121212),
    onSurface: Color(0xFFb3b3b3),
    // Error
    error: Color(0xFFCF6679),
    onError: Color(0xFF121212),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w900,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
  ),
);
