import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/auth/auth_service.dart';

class SplashRepository {
  Future<Either<void, void>> isLoggedIn() async {
    final result = await AuthService.getUserProfile();
    if (result['status_code'] == 200) {
      UserModel.init(result['data']);
      return const Right<void, void>(null);
    }

    return const Left<void, void>(null);
  }
}
