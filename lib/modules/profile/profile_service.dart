import 'package:e_commerce/shared/dummy_data/api/api.dart';
import 'package:e_commerce/shared/local/prefs.dart';

abstract class ProfileService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> logout() {
    return _api.logout();
  }

  static Future<Map<String, dynamic>> getUserProfile() async {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey) ?? -1;
    return await _api.queryUserProfile(userToken);
  }
}
