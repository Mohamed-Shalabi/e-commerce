import 'package:e_commerce/shared/dummy_data/api/api.dart';
import 'package:e_commerce/shared/local/prefs.dart';

abstract class MyOrdersService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> fetchMyOrders() {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.queryOrders(userToken);
  }
}
