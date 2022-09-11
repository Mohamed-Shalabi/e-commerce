import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Colors.purple;
  static const onPrimary = Colors.white;
  static const secondary = Colors.amber;
  static const onSecondary = Colors.black;
  static const error = Colors.red;
  static const onError = Colors.white;
  static final lightBackground = Colors.grey.shade300;
  static const onLightBackground = Colors.black;
  static const lightSurface = Colors.white;
  static const onLightSurface = Colors.black;
  static const darkBackground = Colors.black;
  static const onDarkBackground = Colors.grey;
  static final darkSurface = Colors.grey.shade900;
  static final onDarkSurface = Colors.grey.shade200;
  static const favourites = Colors.red;
  static const muchQuantityColor = Colors.green;
}

abstract class ColorSchemes {
  static final ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    error: AppColors.error,
    onError: AppColors.onError,
    background: AppColors.lightBackground,
    onBackground: AppColors.onLightBackground,
    surface: AppColors.lightSurface,
    onSurface: AppColors.onLightSurface,
  );

  static final ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary.shade200,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    error: AppColors.error,
    onError: AppColors.onError,
    background: AppColors.darkBackground,
    onBackground: AppColors.onDarkBackground,
    surface: AppColors.darkSurface,
    onSurface: AppColors.onDarkSurface,
  );
}
