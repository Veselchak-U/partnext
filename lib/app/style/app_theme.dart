import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.backgroundRed,
      onPrimary: AppColors.textWhite,
      secondary: AppColors.backgroundYellow,
      onSecondary: AppColors.textBlack,
      error: AppColors.backgroundRed,
      onError: AppColors.textWhite,
      surface: AppColors.backgroundWhite,
      onSurface: AppColors.textBlack,
    ),
    primaryColor: AppColors.backgroundRed,
    navigationBarTheme: _navigationBarThemeLight,
    textButtonTheme: _textButtonThemeLight,
    dividerTheme: _dividerThemeLight,
    textSelectionTheme: _textSelectionThemeLight,
    checkboxTheme: _checkboxThemeLight,
    radioTheme: _radioThemeLight,
  );

  static const systemOverlayStyleLight = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static const _navigationBarThemeLight = NavigationBarThemeData(
    backgroundColor: Colors.white,
  );

  static final _textButtonThemeLight = TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
        AppTextStyles.s16w400,
      ),
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled) ? AppColors.textDisabled : AppColors.textBlack,
      ),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
    ),
  );

  static const _dividerThemeLight = DividerThemeData(
    color: AppColors.divider,
    space: 1,
  );

  static final _textSelectionThemeLight = TextSelectionThemeData(
    cursorColor: AppColors.backgroundGreen,
    selectionHandleColor: AppColors.backgroundGreen,
    selectionColor: AppColors.backgroundGreen.withOpacity(0.3),
  );

  static final _checkboxThemeLight = CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.disabled)
          ? AppColors.backgroundIconDisabled
          : states.contains(WidgetState.selected)
              ? AppColors.backgroundYellow
              : AppColors.backgroundWhite,
    ),
  );
  static final _radioThemeLight = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.disabled)
          ? AppColors.backgroundIconDisabled
          : states.contains(WidgetState.selected)
              ? AppColors.backgroundYellow
              : AppColors.backgroundBlack,
    ),
  );
}
