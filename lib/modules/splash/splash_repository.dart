import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/auth/auth_service.dart';

class SplashRepository {
  bool isLoggedIn() {
    final result = AuthLocalService.getUser();
    if (result.isNotEmpty) {
      UserModel.init(result);
      return true;
    }

    return false;
  }
}
