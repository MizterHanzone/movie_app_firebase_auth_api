import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.red,
  scaffoldBackgroundColor: const Color(0xFF121212), // Dark background
  colorScheme: const ColorScheme.dark(
    primary: Colors.red,
    secondary: Colors.red, // Accent color
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: Colors.white70, fontSize: 16),
    labelLarge: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.red,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.black,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white70),
      borderRadius: BorderRadius.circular(20),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white70),
      borderRadius: BorderRadius.circular(20),
    ),
    labelStyle: const TextStyle(color: Colors.white70),
    hintStyle: const TextStyle(color: Colors.white54),
  ),
);
