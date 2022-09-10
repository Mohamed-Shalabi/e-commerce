import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/cart/cart_service.dart';
import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class CartRepository {
  static Future<void> initCart() async {
    try {
      final map = await CartService.fetchCart();
      CartModel.init(map['data']);
    } catch (_) {
      CartModel.init({});
    }
  }

  static Future<void> addProductToCart(ProductModel product) async {
    final cart = CartModel.getInstance();
    final result = await CartService.addProductToCart(product.id);
    if (result['status_code'] == 200) {
      cart.addProduct(product);
      return;
    }

    throw RequestException(result['message']);
  }

  static Future<void> removeProductToCart(ProductModel product) async {
    final cart = CartModel.getInstance();
    final result = await CartService.removeProductFromCart(product.id);
    if (result['status_code'] == 200) {
      cart.removeProduct(product);
      return;
    }

    throw RequestException(result['message']);
  }
}
