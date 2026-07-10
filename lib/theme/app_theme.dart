// lib/theme/app_theme.dart
//
// Two themes, not light/dark-mode variants: `restTheme` is wired as the
// app's permanent default (list, add/edit, settings screens). `alertTheme`
// is applied explicitly by wrapping just the dismiss screen in its own
// Theme() widget once that screen exists — it isn't a system-brightness
// toggle, it's tied to app state (browsing vs. actively dismissing).
//
// Requires the `google_fonts` package (add to pubspec.yaml, then
// `flutter pub get`).

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const fog = Color(0xFFE7E8E2); // rest-state background
  static const ink = Color(0xFF1C1F24); // primary text on fog
  static const slate = Color(0xFF5B6169); // secondary text, borders
  static const char = Color(0xFF14171C); // alert-state background
  static const signal = Color(0xFFD62828); // dismiss-screen accent only
  static const moss = Color(0xFF4C7A5D); // step-progress indicator
}

class AppTypography {
  AppTypography._();

  static TextStyle display({required Color color, double size = 44}) {
    return GoogleFonts.archivo(
      fontWeight: FontWeight.w800,
      fontSize: size,
      letterSpacing: -1,
      color: color,
    );
  }

  /// Standard UI text
  static TextStyle body({
    required Color color,
    double size = 14,
    FontWeight weight = FontWeight.w400,
  }) {
    return GoogleFonts.ibmPlexSans(
      fontWeight: weight,
      fontSize: size,
      color: color,
    );
  }

  /// Numeric/data text
  static TextStyle mono({
    required Color color,
    double size = 13,
    FontWeight weight = FontWeight.w400,
  }) {
    return GoogleFonts.ibmPlexMono(
      fontWeight: weight,
      fontSize: size,
      color: color,
    );
  }
}

class AppTheme {
  AppTheme._();

  /// Everything except the dismiss screen: alarm list, add/edit, settings.
  /// MaterialApp's default theme:
  static ThemeData get restTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.fog,
      colorScheme: const ColorScheme.light(
        surface: AppColors.fog,
        onSurface: AppColors.ink,
        primary: AppColors.ink,
        secondary: AppColors.slate,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.display(color: AppColors.ink),
        bodyMedium: AppTypography.body(color: AppColors.ink),
        bodySmall: AppTypography.body(color: AppColors.slate, size: 13),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.fog
              : const Color(0xFFF5F5F2),
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.ink
              : const Color(0xFFB4B2A9),
        ),
      ),
      dividerColor: const Color(0xFFC9CAC3),
    );
  }

  /// Dismiss screen
  static ThemeData get alertTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.char,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.char,
        onSurface: Color(0xFFF2F2EF),
        primary: AppColors.signal,
        secondary: AppColors.moss,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.display(color: const Color(0xFFF2F2EF)),
        bodyMedium: AppTypography.body(color: AppColors.signal),
        bodySmall: AppTypography.body(
          color: const Color(0xFF9AA0A8),
          size: 13,
        ),
      ),
    );
  }
}