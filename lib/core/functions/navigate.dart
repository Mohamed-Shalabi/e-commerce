import 'package:flutter/material.dart';

extension NavigatorUtil on BuildContext {
  Future<T?> navigate<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<T?> navigateAndRemovePreviousRoutes<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    return await Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }

  void pop<T>([T? result]) => Navigator.of(this).pop(result);
}
