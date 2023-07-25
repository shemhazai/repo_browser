import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repo_browser/app/common/theming/colors.dart';

/// Holds text theme to be used in the app.
class TextThemes {
  static TextTheme build(AppColorScheme colors) {
    final TextStyle base = GoogleFonts.montserrat();

    return TextTheme(
      displayLarge: base.copyWith(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: colors.textHeadline,
        letterSpacing: 0.2,
      ),
      displayMedium: base.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: colors.textHeadline,
        letterSpacing: 0.2,
      ),
      displaySmall: base.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: colors.textHeadline,
        letterSpacing: 0.2,
      ),
      headlineLarge: base.copyWith(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: colors.textHeadline,
        letterSpacing: 0.25,
      ),
      headlineMedium: base.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: colors.textHeadline,
        letterSpacing: 0.25,
      ),
      headlineSmall: base.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: colors.textHeadline,
        letterSpacing: 0,
      ),
      titleLarge: base.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: colors.textHeadline.withOpacity(0.8),
        letterSpacing: 0.15,
      ),
      titleMedium: base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colors.textHeadline,
        letterSpacing: 0.15,
      ),
      titleSmall: base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.textHeadline,
        letterSpacing: 0.5,
      ),
      bodyLarge: base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colors.textBody,
      ),
      bodyMedium: base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colors.textBody,
      ),
      bodySmall: base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: colors.textBody,
        letterSpacing: 0,
      ),
      labelLarge: base.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: colors.textBody,
        height: 1.2,
      ),
      labelMedium: base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: colors.textCaption,
        letterSpacing: 1.5,
      ),
      labelSmall: base.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: colors.textCaption,
        letterSpacing: 1.5,
      ),
    );
  }
}
