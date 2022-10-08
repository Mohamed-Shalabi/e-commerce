import 'package:e_commerce/core/components/my_text.dart';
import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:flutter/material.dart';

extension SnackBarShower on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.secondary,
        content: MyText(message),
      ),
    );
  }
}
