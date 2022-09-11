import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class ProfileService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> logout() {
    return _api.logout();
  }
}
