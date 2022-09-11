import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/cart/blocs/base_shipping_data_cubit.dart';
import 'package:e_commerce/modules/cart/cart_repository.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:flutter/material.dart';

part 'cart_state.dart';

class CartCubit extends BaseShippingDataCubit<CartState> {
  CartCubit() : super(CartInitial()) {
    initCart();
  }

  final couponController = TextEditingController();

  void initCart() async {
    await CartRepository.initCart();
    emit(CartFetched());
  }

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
      await CartRepository.removeProductFromCart(product);
      emit(CartAddOrRemoveProductSucceeded());
    } on BaseException catch (e) {
      emit(CartAddOrRemoveProductFailed(message: e.message));
    }
  }

  void applyCoupon() async {
    emit(ApplyOrRemoveCouponLoading());
    try {
      await CartRepository.applyCoupon(couponController.text.trim());
      emit(ApplyOrRemoveCouponSucceeded());
    } on BaseException catch (e) {
      emit(ApplyOrRemoveCouponFailed(message: e.message));
    }
  }

  void removeCoupon() async {
    emit(ApplyOrRemoveCouponLoading());
    try {
      await CartRepository.removeCoupon();
      emit(ApplyOrRemoveCouponSucceeded());
    } on BaseException catch (e) {
      emit(ApplyOrRemoveCouponFailed(message: e.message));
    }
  }

  void updateFormData() {
    final user = UserModel.getInstance();
    phoneController.text = user.phone;
    countryController.text = user.country;
    cityController.text = user.city;
    addressController.text = user.address;
  }

  Future<void> clearCart() async {
    emit(ClearCartLoading());
    try {
      await CartRepository.clearCart();
      emit(ClearCartSucceeded());
    } on BaseException catch (e) {
      emit(ClearCartFailed(message: e.message));
    }
  }
}
