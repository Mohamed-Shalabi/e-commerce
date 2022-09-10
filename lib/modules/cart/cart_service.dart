import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class CartService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> fetchCart() {
    return _api.queryCart();
  }

  static Future<Map<String, dynamic>> addProductToCart(int productId) {
    return _api.addProductToCart(productId);
  }

  static Future<Map<String, dynamic>> removeProductFromCart(
    int productId,
  ) {
    return _api.removeProductFromCart(productId);
  }

  static Future<Map<String, dynamic>> applyCoupon(String coupon) {
    return _api.applyCoupon(coupon, 100);
  }

  static Future<Map<String, dynamic>> removeCoupon() {
    return _api.removeCoupon();
  }

  static Future<Map<String, dynamic>> clearCart() {
    return _api.clearCart();
  }
}
