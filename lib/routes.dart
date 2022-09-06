import 'package:e_commerce/modules/example/screens/example_screen.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static const exampleScreen = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case exampleScreen:
        return MaterialPageRoute(
          builder: (context) => const ExampleScreen(),
        );
      default:
        throw Exception(AppStrings.routeError);
    }
  }
}
