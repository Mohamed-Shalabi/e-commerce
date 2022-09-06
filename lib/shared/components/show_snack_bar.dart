import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
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
