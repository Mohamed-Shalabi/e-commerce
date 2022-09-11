import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/products/blocs/products/base_products_cubit.dart';
import 'package:e_commerce/modules/wishlist/wishlist_repository.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:flutter/material.dart';

part 'wishlist_state.dart';

class WishlistCubit extends BaseProductsCubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  List<ProductModel> get wishlist => products;

  void getWishlist() async {
    try {
      products = await WishlistRepository.getWishlist();
      emit(WishlistFetched());
    } on BaseException catch (e) {
      emit(WishlistFetchFailed(message: e.message));
    }
  }

  void toggleIsProductInWishlist(int productId) async {
    emit(WishlistToggleProductLoading(productId: productId));
    try {
      if (wishlist.any((element) => element.id == productId)) {
        products = await WishlistRepository.removeProductFromWishlist(
          productId,
        );
      } else {
        products = await WishlistRepository.addProductToWishlist(productId);
      }

      emit(WishlistToggleProductDone());
    } on BaseException catch (e) {
      emit(WishlistFetchFailed(message: e.message));
    }
  }
}
