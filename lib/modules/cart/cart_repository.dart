import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/cart/cart_service.dart';
import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class CartRepository {
  static Future<void> initCart() async {
    try {
      final map = await CartService.fetchCart();
      CartModel.buildInstance(map['data']);
    } catch (_) {
      CartModel.buildInstance({});
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

  static Future<void> removeProductFromCart(ProductModel product) async {
    final cart = CartModel.getInstance();
    final result = await CartService.removeProductFromCart(product.id);
    if (result['status_code'] == 200) {
      cart.removeProduct(product);
      return;
    }

    throw RequestException(result['message']);
  }

  static Future<void> applyCoupon(String coupon) async {
    final result = await CartService.applyCoupon(coupon);
    if (result['status_code'] == 200) {
      CartModel.buildInstance(result['data']);
      return;
    }

    throw RequestException(result['message']);
  }

  static Future<void> removeCoupon() async {
    final result = await CartService.removeCoupon();
    if (result['status_code'] == 200) {
      CartModel.buildInstance(result['data']);
      return;
    }

    throw RequestException(result['message']);
  }

  static Future<void> clearCart() async {
    final result = await CartService.clearCart();
    if (result['status_code'] == 200) {
      CartModel.clear();
      return;
    }

    throw RequestException(result['message']);
  }
}
