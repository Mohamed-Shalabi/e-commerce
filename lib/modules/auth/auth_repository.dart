import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/auth/auth_service.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:e_commerce/shared/errors/global_exceptions.dart';

abstract class AuthRepository {
  static UserModel getUser() {
    UserModel.init(AuthLocalService.getUser());
    return UserModel.getInstance();
  }

  static Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String country,
    required String city,
    required String address,
  }) async {
    try {
      final result = await AuthService.signUp(
        name: name,
        email: email,
        password: password,
        phone: phone,
        country: country,
        city: city,
        address: address,
      );

      if (result['status_code'] == 200) {
        return getUser();
      }

      throw RequestFailedException(result['message']);
    } catch (e) {
      throw RequestFailedException('An error occurred');
    }
  }

  static Future<UserModel> login(String email, String password) async {
    try {
      final result = await AuthService.login(email, password);
      if (result['status_code'] == 200) {
        UserModel.init(result['data']);
        return UserModel.getInstance();
      }

      throw RequestFailedException(result['message']);
    } on BaseException catch (e) {
      throw RequestFailedException(e.message);
    }
  }
}
