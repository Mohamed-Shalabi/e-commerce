import 'package:e_commerce/shared/dummy_data/api/api.dart';
import 'package:e_commerce/shared/local/prefs.dart';

abstract class CartService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> fetchCart() {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.queryCart(userToken);
  }

  static Future<Map<String, dynamic>> addProductToCart(int productId) {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.addProductToCart(productId, userToken);
  }

  static Future<Map<String, dynamic>> removeProductFromCart(
    int productId,
  ) {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.removeProductFromCart(productId, userToken);
  }

  static Future<Map<String, dynamic>> placeOrderAndClearCart() {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.placeOrderAndClearCart(userToken);
  }
}
