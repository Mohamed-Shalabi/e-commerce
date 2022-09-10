import 'package:e_commerce/modules/auth/auth_service.dart';

class SplashRepository {
  bool isLoggedIn() {
    final result = AuthLocalService.getUser();
    return result.isNotEmpty;
  }
}
