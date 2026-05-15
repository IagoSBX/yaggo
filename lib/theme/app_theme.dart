import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────
//  CORES
// ─────────────────────────────────────────────
class AppColors {
  AppColors._();

  static const Color black        = Color(0xFF0C0C0C);
  static const Color black2       = Color(0xFF141414);
  static const Color black3       = Color(0xFF1E1E1E);
  static const Color border       = Color(0xFF2A2A2A);
  static const Color yellow       = Color(0xFFF5C518);
  static const Color yellowDim    = Color(0x1FF5C518);
  static const Color yellowBorder = Color(0x4DF5C518);
  static const Color white        = Color(0xFFF0F0F0);
  static const Color gray         = Color(0xFF666666);
  static const Color gray2        = Color(0xFF444444);
  static const Color success      = Color(0xFF43A047);
  static const Color successDim   = Color(0x2243A047);
  static const Color info         = Color(0xFF42A5F5);
  static const Color infoDim      = Color(0x2242A5F5);

  // burger
  static const Color bunTop    = Color(0xE6C8860A);
  static const Color bunGloss  = Color(0xB3E8A020);
  static const Color cheese    = Color(0xF2F5C518);
  static const Color lettuce   = Color(0xD94A7C2A);
  static const Color patty     = Color(0xE66B2D0A);
}

// ─────────────────────────────────────────────
//  TIPOGRAFIA
// ─────────────────────────────────────────────
class AppText {
  AppText._();

  static TextStyle display(double size, {Color? color}) =>
      GoogleFonts.bebasNeue(
        fontSize: size,
        color: color ?? AppColors.white,
        letterSpacing: 2,
        height: 0.97,
      );

  static TextStyle body(
    double size, {
    Color? color,
    FontWeight? weight,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.dmSans(
        fontSize: size,
        color: color ?? AppColors.white,
        fontWeight: weight ?? FontWeight.w400,
        height: height ?? 1.5,
        letterSpacing: letterSpacing,
      );
}

// ─────────────────────────────────────────────
//  THEME
// ─────────────────────────────────────────────
ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.black,
      primary: AppColors.yellow,
    ),
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black2,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(color: AppColors.yellow),
      titleTextStyle: GoogleFonts.bebasNeue(
        fontSize: 24,
        color: AppColors.yellow,
        letterSpacing: 3,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.black2,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.black2,
      contentTextStyle: GoogleFonts.dmSans(
        fontSize: 13,
        color: AppColors.white,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
