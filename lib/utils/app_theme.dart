import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 🎯 BRAND COLORS (EMERALD + GREY + BROWN BALANCED)
  static const Color primaryEmerald = Color(0xFF10B981);
  static const Color emeraldDark = Color(0xFF047857);

  static const Color accentBrown = Color(0xFF8B5E3C);
  static const Color lightBrown = Color(0xFFD6C2A8);

  // 🔥 GREY SYSTEM (LAYERED DEPTH)
  static const Color greyBackground = Color(0xFFF5F7F6);
  static const Color greyLight = Color(0xFFF9FAFB);
  static const Color greyMedium = Color(0xFFE5E7EB);

  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);

  // 🔥 LEGACY SUPPORT (NO BREAK)
  static const Color primaryGreen = primaryEmerald;
  static const Color accentYellow = accentBrown;
  static const Color primaryIndigo = primaryEmerald;
  static const Color secondaryCyan = accentBrown;
  static const Color accentGold = accentBrown;
  static const Color background = greyBackground;
  static const Color softBackground = greyBackground;

  // 🌈 PREMIUM GRADIENT (WITH BROWN DEPTH)
  static const Gradient primaryGradient = LinearGradient(
    colors: [
      primaryEmerald,
      accentBrown, // 👈 ADDED FOR DEPTH
      emeraldDark,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 💎 SHADOW SYSTEM
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
      scaffoldBackgroundColor: greyBackground,

      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryEmerald,
        primary: primaryEmerald,
        secondary: accentBrown,
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

      // 📱 APPBAR (GLASS READY)
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

      // 🔘 PRIMARY BUTTON (EMERALD)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryEmerald,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),

      // ✏️ INPUT (LAYERED GREY SYSTEM)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: greyLight, // 👈 better than plain white
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),

      // 🏷️ CHIP (STRONGER BROWN)
      chipTheme: ChipThemeData(
        backgroundColor: lightBrown.withValues(alpha: 0.25),
        selectedColor: accentBrown.withValues(alpha: 0.35),
        labelStyle: const TextStyle(color: textPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // 🧾 CARD (LAYERED SURFACE)
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        shadowColor: Colors.black.withValues(alpha: 0.05),
      ),

      // 🔥 DIVIDER (FOR SECTION SEPARATION)
      dividerTheme: const DividerThemeData(color: greyMedium, thickness: 1),
    );
  }
}
