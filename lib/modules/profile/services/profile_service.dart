import 'package:e_commerce/core/database/api/api.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/local/prefs.dart';

abstract class ProfileService {
  static final _api = Api.getInstance();

  static Future<FakeHttpResponse> logout() {
    return _api.logout();
  }

  static Future<FakeHttpResponse> getUserProfile() async {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey) ?? -1;
    return await _api.queryUserProfile(userToken);
  }
}
