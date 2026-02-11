import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryGold = Color(0xFFFFD700);
  static const Color secondaryGold = Color(0xFFC5A000);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color accentColor = Color(0xFF64FFDA);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryGold,
    scaffoldBackgroundColor: backgroundDark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGold,
      brightness: Brightness.dark,
      primary: primaryGold,
      secondary: accentColor,
      surface: surfaceDark,
    ),
    textTheme:
        GoogleFonts.outfitTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ).copyWith(
          displayLarge: GoogleFonts.outfit(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleLarge: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: secondaryGold,
    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    colorScheme: ColorScheme.fromSeed(
      seedColor: secondaryGold,
      brightness: Brightness.light,
      primary: secondaryGold,
      secondary: Colors.blueAccent,
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.outfitTextTheme(
      ThemeData(brightness: Brightness.light).textTheme,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
