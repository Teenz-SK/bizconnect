import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 🌿 B2B Brand Colors
  static const Color primaryGreen = Color(0xFF0A8F3D);
  static const Color accentGold = Color(0xFFFFD600);

  static const Color softBackground = Color(0xFFF4F7F5);
  static const Color surface = Colors.white;

  static const Color textDark = Color(0xFF1B2E22);
  static const Color textSecondary = Color(0xFF5F7A6B);

  // 🔥 BACKWARD COMPATIBILITY (CONST FIX ✅)
  static const Color primaryIndigo = primaryGreen;
  static const Color secondaryCyan = accentGold;

  // 🔥 ALSO ADD THESE (IMPORTANT FOR OLD CODE)
  static const Color background = softBackground;
  static const Color textPrimary = textDark;

  // 🌈 Gradient (CONST SAFE)
  static const Gradient primaryGradient = LinearGradient(
    colors: [primaryGreen, Color(0xFF13B85C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 🚀 MAIN THEME
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: softBackground,

      // 🎨 COLOR SYSTEM
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: accentGold,
        surface: surface,
      ),

      // 🔤 TYPOGRAPHY
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayMedium: GoogleFonts.plusJakartaSans(
          color: textDark,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          color: textDark,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          color: textDark,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          color: textSecondary,
          fontSize: 14,
        ),
      ),

      // 📱 APP BAR
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // 🧾 CARD
      cardTheme: const CardThemeData(
        color: surface,
        elevation: 3,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      // ✏️ INPUT FIELD
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: primaryGreen, width: 2),
        ),

        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),

      // 🔘 BUTTON
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // 🏷️ CHIP
      chipTheme: ChipThemeData(
        backgroundColor: primaryGreen.withOpacity(0.1),
        selectedColor: primaryGreen,
        labelStyle: const TextStyle(color: textDark),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      // ➖ DIVIDER
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE2E8F0),
        thickness: 1,
      ),
    );
  }
}