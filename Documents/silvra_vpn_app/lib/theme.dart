// lib/theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Brand colors
const Color primaryColor = Color(0xFFD32F2F); // Proton-style deep red
const Color secondaryColor = Color(0xFFEF5350); // Lighter red accent
const Color errorColor = Color(0xFFD32F2F);

/// Gradient backgrounds for light & dark modes
const LinearGradient lightGradient = LinearGradient(
  colors: [Color(0xFFD32F2F), Color(0xFFFFFFFF)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const LinearGradient darkGradient = LinearGradient(
  colors: [Color(0xFF8B0000), Color(0xFF000000)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
    secondary: secondaryColor,
    error: errorColor,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.transparent, // Gradient ke liye transparent
  textTheme: GoogleFonts.poppinsTextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
    secondary: secondaryColor,
    error: errorColor,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.transparent, // Gradient ke liye transparent
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.dark().textTheme,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[850],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
);
