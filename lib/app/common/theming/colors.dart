import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'colors.freezed.dart';

/// Lists color schemes.
class ColorSchemes {
  static const AppColorScheme light = AppColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF3B4834),
    primaryContainer: AppColors.gray4,
    onPrimary: AppColors.white,
    secondary: Color(0xFF6C7355),
    secondaryContainer: Color(0xFB3B4834),
    onSecondary: AppColors.gray8,
    background: AppColors.gray8,
    onBackground: AppColors.gray1,
    surface: AppColors.white,
    onSurface: AppColors.gray1,
    error: Color(0xFFC62121),
    onError: AppColors.white,
    divider: Colors.black26,

    // widgets
    disabled: Color(0x503B4834),
    unselected: Color(0xA86C7355),
    highlight: Color(0x2C3B4834),
    canvas: AppColors.white,
    navigationBar: Color(0xFF3B4834),

    // texts
    textHeadline: Color(0xDF3B4834),
    textBody: Color(0xFF3B4834),
    textCaption: Color.fromRGBO(65, 74, 57, 0.8),
    cursor: Color.fromRGBO(157, 157, 157, 1),
  );

  static const AppColorScheme dark = AppColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.white,
    primaryContainer: AppColors.gray5,
    onPrimary: AppColors.white,
    secondary: Color.fromRGBO(122, 195, 142, 0.5),
    secondaryContainer: Color(0xFFE98634),
    onSecondary: AppColors.white,
    background: Color.fromARGB(255, 30, 30, 30),
    onBackground: AppColors.white,
    surface: Color.fromRGBO(45, 46, 48, 1),
    onSurface: AppColors.white,
    error: Color(0xFFC62121),
    onError: AppColors.white,
    divider: AppColors.gray3,

    // widgets
    disabled: Color.fromRGBO(122, 195, 142, 0.4),
    unselected: Color.fromRGBO(122, 195, 142, 0.65),
    highlight: Color.fromRGBO(122, 195, 142, 0.35),
    canvas: AppColors.gray2,
    navigationBar: Color.fromARGB(255, 37, 37, 38),

    // texts
    textHeadline: AppColors.gray9,
    textBody: AppColors.gray9,
    textCaption: AppColors.gray9,
    cursor: AppColors.gray8,
  );
}

/// Similar to [ColorScheme] but allows to define custom colors.
@freezed
class AppColorScheme with _$AppColorScheme {
  const AppColorScheme._();

  const factory AppColorScheme({
    required Brightness brightness,

    /// base
    required Color primary,
    required Color primaryContainer,
    required Color onPrimary,
    required Color secondary,
    required Color secondaryContainer,
    required Color onSecondary,
    required Color background,
    required Color onBackground,
    required Color surface,
    required Color onSurface,
    required Color error,
    required Color onError,
    required Color divider,

    // widgets
    required Color disabled,
    required Color unselected,
    required Color highlight,
    required Color canvas,
    required Color navigationBar,

    /// texts
    required Color textHeadline,
    required Color textBody,
    required Color textCaption,
    required Color cursor,
  }) = _AppColorScheme;

  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      primaryContainer: primaryContainer,
      onPrimary: onPrimary,
      secondary: secondary,
      secondaryContainer: secondaryContainer,
      onSecondary: onSecondary,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      error: error,
      onError: onError,
    );
  }

  static AppColorScheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return ofBrightness(brightness);
  }

  static AppColorScheme ofBrightness(Brightness brightness) {
    if (brightness == Brightness.dark) return ColorSchemes.dark;
    return ColorSchemes.light;
  }
}

/// Holds a palette of app colors.
/// Do no use directly - access colors through [ColorScheme] or [AppColorScheme]
/// ```
/// var colorScheme = Theme.of(context).colorScheme; /// base palette
/// var colorScheme = AppColorScheme.of(context);    /// custom palette
/// ```
class AppColors {
  const AppColors();

  // grayscale
  static const Color black = Color(0xFF000000);
  static const Color gray1 = Color(0xFF303030);
  static const Color gray2 = Color(0xFF444444);
  static const Color gray3 = Color(0xFF606060);
  static const Color gray4 = Color(0xFF808080);
  static const Color gray5 = Color(0xFFA0A0A0);
  static const Color gray6 = Color(0xFFCECECE);
  static const Color gray7 = Color(0xFFE7E7E7);
  static const Color gray8 = Color.fromARGB(255, 245, 245, 245);
  static const Color gray9 = Color.fromARGB(255, 245, 245, 220);
  static const Color white = Color.fromARGB(255, 252, 252, 252);
}
