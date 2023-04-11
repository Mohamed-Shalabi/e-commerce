import 'package:e_commerce/core/database/api/api.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';

abstract class AuthService {
  static final _api = Api.getInstance();

  static Future<FakeHttpResponse> signUp({
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

  static Future<FakeHttpResponse> login(String email, String password) {
    return _api.login(email, password);
  }
}
