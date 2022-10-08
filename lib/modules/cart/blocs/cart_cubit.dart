import 'package:e_commerce/modules/cart/repositories/cart_repository.dart';
import 'package:e_commerce/modules/products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
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

  void placeOrderAndClearCart() {
    emit(PlaceOrderLoading());
    CartRepository.placeOrderAndClearCart();
  }
}
