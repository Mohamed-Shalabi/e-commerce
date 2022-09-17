import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/cart/cart_service.dart';

abstract class CartRepository {
  static Future<Either<void, void>> initCart() async {
    try {
      final map = await CartService.fetchCart();
      CartModel.buildInstance(map['data']);
      return const Right<void, void>(null);
    } catch (_) {
      CartModel.buildInstance({});
      return const Left<void, void>(null);
    }
  }

  static Future<Either<String, void>> addProductToCart(
    BaseProductModel product,
  ) async {
    final cart = CartModel.getInstance();
    final result = await CartService.addProductToCart(product.id);
    if (result['status_code'] == 200) {
      cart.addProduct(product);
      return const Right<String, void>(null);
    }

    return Left<String, void>(result['message']);
  }

  static Future<Either<String, void>> removeProductFromCart(
    BaseProductModel product,
  ) async {
    final cart = CartModel.getInstance();
    final result = await CartService.removeProductFromCart(product.id);
    if (result['status_code'] == 200) {
      cart.removeProduct(product);
      return const Right<String, void>(null);
    }

    return Left<String, void>(result['message']);
  }

  static Future<Either<String, void>> applyCoupon(String coupon) async {
    final result = await CartService.applyCoupon(coupon);
    if (result['status_code'] == 200) {
      CartModel.buildInstance(result['data']);
      return const Right<String, void>(null);
    }

    return Left<String, void>(result['message']);
  }

  static Future<Either<String, void>> removeCoupon() async {
    final result = await CartService.removeCoupon();
    if (result['status_code'] == 200) {
      CartModel.buildInstance(result['data']);
      return const Right<String, void>(null);
    }

    return Left<String, void>(result['message']);
  }

  static final _placeOrderStreamController =
      StreamController<Either<String, void>>.broadcast();

  static void listenToPlaceOrderStream(
    void Function(Either<String, void> event) action,
  ) {
    _placeOrderStreamController.stream.listen(action);
  }

  static Future<void> placeOrderAndClearCart() async {
    final result = await CartService.placeOrderAndClearCart();
    if (result['status_code'] == 200) {
      CartModel.clear();
      _placeOrderStreamController.add(const Right<String, void>(null));
      return;
    }

    _placeOrderStreamController.add(Left<String, void>(result['message']));
  }
}
