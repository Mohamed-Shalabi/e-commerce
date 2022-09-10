import 'package:e_commerce/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';

abstract class TextThemes {
  static TextTheme getTextTheme({required bool isLight}) {
    final colorScheme =
        isLight ? ColorSchemes.lightColorScheme : ColorSchemes.darkColorScheme;

    return const TextTheme();
  }
}
