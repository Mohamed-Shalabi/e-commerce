import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';

abstract class Routes {

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        throw Exception(AppStrings.routeError);
    }
  }
}
