import 'package:e_commerce/modules/auth/auth_service.dart';

class SplashRepository {
  final _authLocalService = AuthLocalService();
  
  bool isLoggedIn() {
    final result = _authLocalService.getUser();
    return result.isNotEmpty;
  }
}