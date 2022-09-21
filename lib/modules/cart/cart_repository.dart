import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/cart/cart_service.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';

abstract class CartRepository {
  static Future<Either<String, void>> initCart() async {
    try {
      final map = await CartService.fetchCart();
      if (map['status_code'] == 200) {
        CartModel.buildInstance(map['data']);
        return const Right<String, void>(null);
      }

      CartModel.buildInstance({});
      return const Left<String, void>(AppStrings.cartError);
    } on SocketException {
      return const Left<String, void>(AppStrings.connectionError);
    } catch (_) {
      CartModel.buildInstance({});
      return const Left<String, void>(AppStrings.unknownError);
    }
  }

  static void initCartEmpty() {
    CartModel.buildInstance({});
  }

  static Future<Either<String, void>> addProductToCart(
    BaseProductModel product,
  ) async {
    try {
      final cart = CartModel.getInstance();
      final result = await CartService.addProductToCart(product.id);
      if (result['status_code'] == 200) {
        cart.addProduct(product);
        return const Right<String, void>(null);
      }

      return Left<String, void>(result['message']);
    } on SocketException {
      return const Left<String, void>(AppStrings.connectionError);
    } catch (_) {
      return const Left<String, void>(AppStrings.unknownError);
    }
  }

  static Future<Either<String, void>> removeProductFromCart(
    BaseProductModel product,
  ) async {
    try {
      final cart = CartModel.getInstance();
      final result = await CartService.removeProductFromCart(product.id);
      if (result['status_code'] == 200) {
        cart.removeProduct(product);
        return const Right<String, void>(null);
      }

      return Left<String, void>(result['message']);
    } on SocketException {
      return const Left<String, void>(AppStrings.connectionError);
    } catch (_) {
      return const Left<String, void>(AppStrings.unknownError);
    }
  }

  static Future<Either<String, void>> applyCoupon(String coupon) async {
    try {
      final result = await CartService.applyCoupon(coupon);
      if (result['status_code'] == 200) {
        CartModel.buildInstance(result['data']);
        return const Right<String, void>(null);
      }

      return Left<String, void>(result['message']);
    } on SocketException {
      return const Left<String, void>(AppStrings.connectionError);
    } catch (_) {
      return const Left<String, void>(AppStrings.unknownError);
    }
  }

  static Future<Either<String, void>> removeCoupon() async {
    try {
      final result = await CartService.removeCoupon();
      if (result['status_code'] == 200) {
        CartModel.buildInstance(result['data']);
        return const Right<String, void>(null);
      }

      return Left<String, void>(result['message']);
    } on SocketException {
      return const Left<String, void>(AppStrings.connectionError);
    } catch (_) {
      return const Left<String, void>(AppStrings.unknownError);
    }
  }

  static final _placeOrderStreamController =
      StreamController<Either<String, void>>.broadcast();

  static void listenToPlaceOrderStream(
    void Function(Either<String, void> event) action,
  ) {
    _placeOrderStreamController.stream.listen(action);
  }

  static Future<void> placeOrderAndClearCart() async {
    try {
      final result = await CartService.placeOrderAndClearCart();
      if (result['status_code'] == 200) {
        CartModel.clear();
        _placeOrderStreamController.add(const Right<String, void>(null));
        return;
      }

      _placeOrderStreamController.add(Left<String, void>(result['message']));
    } on SocketException {
      _placeOrderStreamController.add(
        const Left<String, void>(AppStrings.connectionError),
      );
      return;
    } catch (_) {
      _placeOrderStreamController.add(
        const Left<String, void>(AppStrings.unknownError),
      );
      return;
    }
  }
}
