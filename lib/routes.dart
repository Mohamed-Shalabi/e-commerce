import 'package:e_commerce/modules/auth/screens/sign_up_screen.dart';
import 'package:e_commerce/modules/main_layout/screens/main_layout.dart';
import 'package:e_commerce/modules/splash/screens/splash_screen.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static const splashRouteName = '/';
  static const mainLayoutRouteName = '/main_layout';
  static const signUpRouteName = '/sign_up';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRouteName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case mainLayoutRouteName:
        return MaterialPageRoute(builder: (_) => const MainLayout());
      case signUpRouteName:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      default:
        throw Exception(AppStrings.routeError);
    }
  }
}
