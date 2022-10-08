import 'package:e_commerce/core/local/prefs.dart';

abstract class SplashLocalService {
  static bool isLoggedIn() {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey) ?? -1;
    return userToken != -1;
  }
}
