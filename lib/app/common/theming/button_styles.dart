import 'package:flutter/material.dart';
import 'package:repo_browser/app/common/theming/colors.dart';
import 'package:repo_browser/app/common/theming/dimens.dart';

/// Contains common buttons styles for [ElevatedButton].
class ElevatedButtonStyles {
  static ButtonStyle positive(BuildContext context) => positiveOf(AppColorScheme.of(context));
  static ButtonStyle positiveOf(AppColorScheme colors) => base(colors.secondary);

  static ButtonStyle negative(BuildContext context) => negativeOf(AppColorScheme.of(context));
  static ButtonStyle negativeOf(AppColorScheme colors) => base(colors.error);

  static ButtonStyle base(Color color) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
      shadowColor: MaterialStateProperty.all(color),
      elevation: MaterialStateProperty.all(Dimens.buttonElevation),
      padding: MaterialStateProperty.all(Insets.button),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.buttonRoundCorners)),
        ),
      ),
    );
  }
}

/// Contains common buttons styles for [OutlinedButton].
class OutlinedButtonStyles {
  static ButtonStyle positive(BuildContext context) => positiveOf(AppColorScheme.of(context));
  static ButtonStyle positiveOf(AppColorScheme colors) => base(colors.primary);

  static ButtonStyle negative(BuildContext context) => negativeOf(AppColorScheme.of(context));
  static ButtonStyle negativeOf(AppColorScheme colors) => base(colors.error);

  static ButtonStyle base(Color color) {
    final BorderSide borderSide = BorderSide(
      color: color.withAlpha(160),
      width: Dimens.buttonBorder,
    );

    return ButtonStyle(
      side: MaterialStateProperty.all(borderSide),
      foregroundColor: MaterialStateProperty.all(color.withAlpha(200)),
      padding: MaterialStateProperty.all(Insets.button),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          side: borderSide,
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.buttonRoundCorners)),
        ),
      ),
    );
  }
}

/// Contains common buttons styles for [TextButton].
class TextButtonStyles {
  static ButtonStyle positive(BuildContext context) => positiveOf(
        Theme.of(context).textTheme,
        AppColorScheme.of(context),
      );

  static ButtonStyle positiveOf(TextTheme textTheme, AppColorScheme colors) => base(
        textTheme: textTheme,
        selectedColor: colors.primary,
        unselectedColor: colors.unselected,
      );

  static ButtonStyle negative(BuildContext context) => negativeOf(
        Theme.of(context).textTheme,
        AppColorScheme.of(context),
      );

  static ButtonStyle negativeOf(TextTheme textTheme, AppColorScheme colors) => base(
        textTheme: textTheme,
        selectedColor: colors.error,
        unselectedColor: colors.error.withAlpha(160),
      );

  static ButtonStyle base({
    required TextTheme textTheme,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    return ButtonStyle(
      textStyle: MaterialStateProperty.all(textTheme.labelLarge!.copyWith(fontSize: 17)),
      minimumSize: MaterialStateProperty.all(Size.zero),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) return selectedColor;
        if (states.contains(MaterialState.pressed)) return selectedColor;
        if (states.contains(MaterialState.selected)) return selectedColor;
        return unselectedColor;
      }),
    );
  }
}
