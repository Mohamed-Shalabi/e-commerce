import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/cart/cart_repository.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit()
      : cart = CartModel.getInstance(),
        super(CartInitial());

  final CartModel cart;

  void addProductToCart(ProductModel product) async {
    emit(CartAddOrRemoveProductLoading());
    try {
      await CartRepository.addProductToCart(product);
      emit(CartAddOrRemoveProductSucceeded());
    } on BaseException catch (e) {
      emit(CartAddOrRemoveProductFailed(message: e.message));
    }
  }

  void removeProductFromCart(ProductModel product) async {
    emit(CartAddOrRemoveProductLoading());
    try {
      await CartRepository.removeProductToCart(product);
      emit(CartAddOrRemoveProductSucceeded());
    } on BaseException catch (e) {
      emit(CartAddOrRemoveProductFailed(message: e.message));
    }
  }
}
