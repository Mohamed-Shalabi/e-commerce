import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/auth/auth_service.dart';

class SplashRepository {
  Future<bool> isLoggedIn() async {
    final result = await AuthService.getUserProfile();
    if (result['status_code'] == 200) {
      UserModel.init(result['data']);
      return true;
    }

    return false;
  }
}
