import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 🎯 BRAND COLORS
  static const Color accentYellow = Color(0xFFFFD600); // 🟡 70%
  static const Color primaryGreen = Color(0xFF0A8F3D); // 🟢 30%

  static const Color softBackground = Color(0xFFF9F9F9);
  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF1B2E22);
  static const Color textSecondary = Color(0xFF64748B);

  // 🔥 LEGACY SUPPORT (NO ERRORS)
  static const Color primaryIndigo = primaryGreen;
  static const Color secondaryCyan = accentYellow;
  static const Color accentGold = accentYellow;
  static const Color background = softBackground;

  // 🌈 GRADIENT
  static const Gradient primaryGradient = LinearGradient(
    colors: [primaryGreen, Color(0xFF086B2E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 💎 PREMIUM SHADOW SYSTEM
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 25,
      offset: const Offset(0, 12),
    ),
  ];

  // 🚀 MAIN THEME
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: softBackground,

      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: accentYellow,
        surface: surface,
      ),

      // 🔤 TYPOGRAPHY
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayMedium: const TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: const TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: const TextStyle(color: textPrimary),
        bodyMedium: const TextStyle(color: textSecondary),
      ),

      // 📱 APPBAR (GLASS STYLE)
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),

      // 🔘 BUTTON
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),

      // ✏️ INPUT (SOFT UI)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),

      // 🏷️ CHIP
      chipTheme: ChipThemeData(
        backgroundColor: accentYellow.withValues(alpha: 0.2),
        selectedColor: accentYellow,
        labelStyle: const TextStyle(color: textPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // 🧾 CARD (SOFT FLOATING)
      cardTheme: const CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
    );
  }
}
