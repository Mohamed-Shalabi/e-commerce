import 'package:flutter/material.dart';

extension NavigatorUtil on BuildContext {
  Future<Object?> navigate(String routeName) {
    return Navigator.of(this).pushNamed(routeName);
  }

  Future<Object?> navigateAndRemovePreviousRoutes(String routeName) {
    return Navigator.of(this).pushNamedAndRemoveUntil(routeName, (_) => true);
  }
}
