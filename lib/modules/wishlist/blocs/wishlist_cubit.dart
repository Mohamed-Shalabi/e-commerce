import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/products/blocs/products/base_products_cubit.dart';
import 'package:e_commerce/modules/wishlist/wishlist_repository.dart';
import 'package:flutter/material.dart';

part 'wishlist_state.dart';

class WishlistCubit extends BaseProductsCubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  List<ProductModel> get wishlist => products;

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
    emit(WishlistToggleProductLoading(productId: productId));

    if (wishlist.any((element) => element.id == productId)) {
      final result = await WishlistRepository.removeProductFromWishlist(
        productId,
      );

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

      result.fold<void>(
        (l) => emit(WishlistToggleProductFailed(message: l)),
        (r) {
          products = r;
          return emit(WishlistToggleProductDone());
        },
      );
    }
  }
}
