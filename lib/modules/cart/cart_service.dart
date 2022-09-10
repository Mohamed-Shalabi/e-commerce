import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class CartService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> fetchCart() async {
    return await _api.queryCart();
  }

  static Future<Map<String, dynamic>> addProductToCart(int productId) async {
    return await _api.addProductToCart(productId);
  }

  static Future<Map<String, dynamic>> removeProductFromCart(
    int productId,
  ) async {
    return await _api.removeProductFromCart(productId);
  }
}
