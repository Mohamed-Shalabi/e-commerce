import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/modules/profile/profile_service.dart';
import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class ProfileRepository {
  static Future<bool> logout() async {
    final result = await ProfileService.logout();
    if (result['status_code'] == 200) {
      return true;
    }

    throw RequestException(result['message']);
  }
}
