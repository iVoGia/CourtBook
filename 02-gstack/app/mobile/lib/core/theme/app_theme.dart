import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// CourtBook theme — aligned with DESIGN.md (teal athletic clarity).
class AppTheme {
  static const Color background = Color(0xFFF8FAF9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFEEF2F0);
  static const Color primary = Color(0xFF0D9488);
  static const Color primaryHover = Color(0xFF0F766E);
  static const Color accent = Color(0xFFEA580C);
  static const Color onBackground = Color(0xFF1A2E24);
  static const Color muted = Color(0xFF5C6F65);
  static const Color border = Color(0xFFD4DDD8);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFCA8A04);
  static const Color danger = Color(0xFFDC2626);

  static const Color sportBadmintonBg = Color(0xFFEDE9FE);
  static const Color sportBadmintonFg = Color(0xFF6D28D9);
  static const Color sportFootballBg = Color(0xFFDBEAFE);
  static const Color sportFootballFg = Color(0xFF1D4ED8);
  static const Color sportTennisBg = Color(0xFFD1FAE5);
  static const Color sportTennisFg = Color(0xFF047857);

  static TextStyle displayBold(double size, {Color? color}) =>
      GoogleFonts.outfit(fontSize: size, fontWeight: FontWeight.w700, color: color ?? onBackground);

  static TextStyle displaySemi(double size, {Color? color}) =>
      GoogleFonts.outfit(fontSize: size, fontWeight: FontWeight.w600, color: color ?? onBackground);

  static TextStyle body({double size = 16, Color? color, FontWeight weight = FontWeight.w400}) =>
      GoogleFonts.dmSans(fontSize: size, fontWeight: weight, color: color ?? onBackground);

  static TextStyle label({Color? color}) =>
      GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w500, color: color ?? muted);

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: accent,
        surface: surface,
        onSurface: onBackground,
      ),
      textTheme: TextTheme(
        headlineMedium: displayBold(28, color: primary),
        titleLarge: displaySemi(20),
        titleMedium: displaySemi(18),
        bodyLarge: body(),
        bodyMedium: body(size: 14, color: muted),
        labelMedium: label(),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: onBackground,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: displaySemi(20),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        labelStyle: body(size: 14, color: muted),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          textStyle: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          side: const BorderSide(color: border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: primary.withValues(alpha: 0.12),
        labelTextStyle: WidgetStateProperty.all(
          GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
    return base;
  }

  static (Color bg, Color fg) sportColors(String sport) {
    switch (sport) {
      case 'badminton':
        return (sportBadmintonBg, sportBadmintonFg);
      case 'mini_football':
        return (sportFootballBg, sportFootballFg);
      case 'tennis':
        return (sportTennisBg, sportTennisFg);
      default:
        return (surfaceMuted, muted);
    }
  }
}
