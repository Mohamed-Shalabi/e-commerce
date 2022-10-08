import 'package:e_commerce/core/database/api/api.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/local/prefs.dart';

abstract class MyOrdersService {
  static final _api = Api.getInstance();

  static Future<FakeHttpResponse> fetchMyOrders() {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.queryOrders(userToken);
  }
}
