import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/cart/blocs/base_shipping_data_cubit.dart';
import 'package:e_commerce/modules/cart/cart_repository.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';

part 'cart_state.dart';

class CartCubit extends BaseShippingDataCubit<CartState> {
  CartCubit() : super(CartInitial()) {
    CartRepository.listenToPlaceOrderStream((event) {
      event.fold<void>(
        (l) => emit(PlaceOrderFailed(message: l)),
        (r) => emit(PlaceOrderSucceeded()),
      );
    });
  }

  final couponController = TextEditingController();
  final _loadingProductsIds = <int>{};

  bool isProductLoading(int id) => _loadingProductsIds.contains(id);

  void initCart() async {
    final result = await CartRepository.initCart();
    result.fold<void>(
      (l) => emit(CartFetchError(message: l)),
      (r) => emit(CartFetched()),
    );
  }

  void initCartEmpty() {
    CartRepository.initCartEmpty();
  }

  void updateFormData() {
    final user = UserModel.getInstance();
    phoneController.text = user.phone;
    countryController.text = user.country;
    cityController.text = user.city;
    addressController.text = user.address;
  }

  void addProductToCart(BaseProductModel product) async {
    _loadingProductsIds.add(product.id);
    emit(CartAddOrRemoveProductLoading());

    final result = await CartRepository.addProductToCart(product);
    _loadingProductsIds.remove(product.id);

    result.fold<void>(
      (l) => emit(CartAddOrRemoveProductFailed(message: l)),
      (r) => emit(CartAddOrRemoveProductSucceeded()),
    );
  }

  void removeProductFromCart(BaseProductModel product) async {
    _loadingProductsIds.add(product.id);
    emit(CartAddOrRemoveProductLoading());

    final result = await CartRepository.removeProductFromCart(product);
    _loadingProductsIds.remove(product.id);

    result.fold<void>(
      (l) => emit(CartAddOrRemoveProductFailed(message: l)),
      (r) => emit(CartAddOrRemoveProductSucceeded()),
    );
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

  void placeOrderAndClearCart() {
    emit(PlaceOrderLoading());
    CartRepository.placeOrderAndClearCart();
  }
}
