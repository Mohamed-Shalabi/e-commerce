import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/wishlist/wishlist_repository.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  List<ProductModel> wishlist = [];

  void getWishlist() async {
    try {
      wishlist = await WishlistRepository.getWishlist();
      emit(WishlistFetched());
    } on BaseException catch (e) {
      emit(WishlistFetchFailed(message: e.message));
    }
  }

  void toggleIsProductInWishlist(int productId) async {
    emit(WishlistToggleProductLoading(productId: productId));
    try {
      if (wishlist.any((element) => element.id == productId)) {
        wishlist = await WishlistRepository.removeProductFromWishlist(
          productId,
        );
      } else {
        wishlist = await WishlistRepository.addProductToWishlist(productId);
      }

      emit(WishlistToggleProductDone());
    } on BaseException catch (e) {
      emit(WishlistFetchFailed(message: e.message));
    }
  }
}
