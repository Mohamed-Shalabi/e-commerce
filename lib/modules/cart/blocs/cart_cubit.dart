import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/cart/blocs/base_shipping_data_cubit.dart';
import 'package:e_commerce/modules/cart/cart_repository.dart';
import 'package:flutter/material.dart';

part 'cart_state.dart';

class CartCubit extends BaseShippingDataCubit<CartState> {
  CartCubit() : super(CartInitial()) {
    initCart();
  }

  final couponController = TextEditingController();

  void initCart() async {
    final result = await CartRepository.initCart();
    result.fold(
      (l) => null,
      (r) => emit(CartFetched()),
    );
  }

  void updateFormData() {
    final user = UserModel.getInstance();
    phoneController.text = user.phone;
    countryController.text = user.country;
    cityController.text = user.city;
    addressController.text = user.address;
  }

  void applyCoupon() async {
    emit(ApplyOrRemoveCouponLoading());
    final result = await CartRepository.applyCoupon(
      couponController.text.trim(),
    );

    result.fold<void>(
      (l) => emit(ApplyOrRemoveCouponFailed(message: l)),
      (r) => emit(ApplyOrRemoveCouponSucceeded()),
    );
  }

  void removeCoupon() async {
    emit(ApplyOrRemoveCouponLoading());

    final result = await CartRepository.removeCoupon();
    result.fold<void>(
      (l) => emit(ApplyOrRemoveCouponFailed(message: l)),
      (r) => emit(ApplyOrRemoveCouponSucceeded()),
    );
  }

  Future<void> clearCart() async {
    emit(ClearCartLoading());
    final result = await CartRepository.clearCart();
    result.fold<void>(
      (l) => emit(ClearCartFailed(message: l)),
      (r) => emit(ClearCartSucceeded()),
    );
  }

  void removeProductFromCart(ProductModel product) {
    emit(CartAddOrRemoveProductSucceeded());
  }
}
