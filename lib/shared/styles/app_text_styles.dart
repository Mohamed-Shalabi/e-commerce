import 'package:e_commerce/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';

abstract class TextThemes {
  static TextTheme getTextTheme({required bool isLight}) {
    final colorScheme =
        isLight ? ColorSchemes.lightColorScheme : ColorSchemes.darkColorScheme;

    return TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),
      titleMedium: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),
    );
  }
}
