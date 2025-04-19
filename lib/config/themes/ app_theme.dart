import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFDE21), // Yellow as the base
    brightness: Brightness.light,
    primary: const Color(0xFFFFDE21), // Explicitly set primary to yellow
    onPrimary: Colors.black87, // Text/icon color on primary
    surface: Colors.white, // Background for cards, scaffolds, etc.
    onSurface: Colors.black87, // Text/icon color on surface
  ),
  useMaterial3: true,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFDE21), // Yellow for AppBar
    foregroundColor: Colors.black87, // Text/icons on AppBar
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFFDE21), // Yellow for buttons
      foregroundColor: Colors.black87, // Text/icons on buttons
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFFDE21), // Yellow for FAB
    foregroundColor: Colors.black87,
  ),
);

   final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF4DD0E1), // Teal blue for dark mode
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF4DD0E1),
      foregroundColor: Colors.white,
    ),
  );

