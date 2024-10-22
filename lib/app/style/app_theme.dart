import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partnext/app/assets/fonts.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    fontFamily: FontFamily.montserrat,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.primaryLight,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.primary,
    ),
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
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
        AppTextStyles.s14w700.copyWith(
          fontFamily: FontFamily.montserrat,
          decoration: TextDecoration.underline,
        ),
      ),
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled) ? AppColors.gray : AppColors.primaryLight,
      ),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
    ),
  );

  static const _dividerThemeLight = DividerThemeData(
    color: AppColors.gray,
    space: 1,
  );

  static final _textSelectionThemeLight = TextSelectionThemeData(
    cursorColor: AppColors.primary,
    selectionHandleColor: AppColors.primary,
    selectionColor: AppColors.primary.withOpacity(0.3),
  );

  static final _checkboxThemeLight = CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.disabled)
          ? AppColors.gray
          : states.contains(WidgetState.selected)
              ? AppColors.orange
              : AppColors.white,
    ),
  );
  static final _radioThemeLight = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.disabled)
          ? AppColors.gray
          : states.contains(WidgetState.selected)
              ? AppColors.orange
              : AppColors.white,
    ),
  );
}
