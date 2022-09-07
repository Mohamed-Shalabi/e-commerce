import 'package:flutter/material.dart';

extension NavigatorUtil on BuildContext {
  Future<T?> navigate<T extends Object?>(String routeName) {
    return Navigator.of(this).pushNamed(routeName);
  }

  Future<T?> navigateAndRemovePreviousRoutes<T extends Object?>(
    String routeName,
  ) async {
    return await Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (_) => true,
    );
  }
}
