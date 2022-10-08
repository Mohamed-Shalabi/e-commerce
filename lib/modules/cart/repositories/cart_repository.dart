import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/cart/models/cart_model.dart';
import 'package:e_commerce/modules/cart/services/cart_service.dart';
import 'package:e_commerce/modules/products/models/product_model.dart';

abstract class CartRepository {
  static Future<Either<String, void>> initCart() async {
    try {
      final map = await CartService.fetchCart();
      if (map.statusCode == 200) {
        final data = json.decode(map.body);
        CartModel.buildInstance(data);
        return const Right<String, void>(null);
      }

      initCartEmpty();
      return const Left<String, void>(AppStrings.cartError);
    } on SocketException {
      return const Left<String, void>(AppStrings.connectionError);
    } catch (_) {
      initCartEmpty();
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
      if (result.statusCode == 200) {
        cart.addProduct(product);
        return const Right<String, void>(null);
      }

      return Left<String, void>(result.body);
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
      if (result.statusCode == 200) {
        cart.removeProduct(product);
        return const Right<String, void>(null);
      }

      return Left<String, void>(result.body);
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
      if (result.statusCode == 200) {
        CartModel.clean();
        _placeOrderStreamController.add(const Right<String, void>(null));
        return;
      }

      _placeOrderStreamController.add(Left<String, void>(result.body));
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
