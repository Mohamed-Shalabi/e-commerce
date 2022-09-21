import 'package:e_commerce/shared/dummy_data/api/api.dart';
import 'package:e_commerce/shared/local/prefs.dart';

abstract class AuthService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String country,
    required String city,
    required String address,
  }) {
    return _api.signUp(
      name: name,
      email: email,
      password: password,
      phone: phone,
      country: country,
      city: city,
      address: address,
    );
  }

  static Future<Map<String, dynamic>> login(String email, String password) {
    return _api.login(email, password);
  }
}
