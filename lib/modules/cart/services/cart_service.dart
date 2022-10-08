import 'package:e_commerce/core/database/api/api.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/local/prefs.dart';

abstract class CartService {
  static final _api = Api.getInstance();

  static Future<FakeHttpResponse> fetchCart() {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.queryCart(userToken);
  }

  static Future<FakeHttpResponse> addProductToCart(int productId) {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.addProductToCart(productId, userToken);
  }

  static Future<FakeHttpResponse> removeProductFromCart(
    int productId,
  ) {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.removeProductFromCart(productId, userToken);
  }

  static Future<FakeHttpResponse> placeOrderAndClearCart() {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.placeOrderAndClearCart(userToken);
  }
}
