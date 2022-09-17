import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/wishlist_model.dart';
import 'package:e_commerce/modules/products/blocs/products/base_products_cubit.dart';
import 'package:e_commerce/modules/wishlist/wishlist_repository.dart';
import 'package:flutter/material.dart';

part 'wishlist_state.dart';

class WishlistCubit extends BaseProductsCubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  final _wishlist = WishlistModel.getInstance();
  final _loadingProductsIds = <int>{};

  bool isProductLoading(int id) => _loadingProductsIds.contains(id);

  void getWishlist() async {
    final result = await WishlistRepository.getWishlist();
    result.fold<void>(
      (l) => emit(WishlistFetchFailed(message: l)),
      (r) {
        products = r;
        emit(WishlistFetched());
      },
    );
  }

  void toggleIsProductInWishlist(int productId) async {
    _loadingProductsIds.add(productId);
    emit(WishlistToggleProductLoading());

    if (_wishlist.any((element) => element.id == productId)) {
      final result = await WishlistRepository.removeProductFromWishlist(
        productId,
      );

      _loadingProductsIds.remove(productId);

      result.fold<void>(
        (l) => emit(WishlistToggleProductFailed(message: l)),
        (r) {
          products = r;
          return emit(WishlistToggleProductDone());
        },
      );
    } else {
      final result = await WishlistRepository.addProductToWishlist(
        productId,
      );

      _loadingProductsIds.remove(productId);

      result.fold<void>(
        (l) => emit(WishlistToggleProductFailed(message: l)),
        (r) {
          products = r;
          return emit(WishlistToggleProductDone());
        },
      );
    }
  }

  @override
  Iterable<ProductListModel> get products => _wishlist;

  @override
  set products(Iterable<ProductListModel> products) {
    _wishlist
      ..clear()
      ..addAll(products);
  }

  void clearWishlist() {
    _wishlist.clear();
  }
}
