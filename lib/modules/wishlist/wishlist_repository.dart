import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/wishlist/wishlist_service.dart';

abstract class WishlistRepository {
  static Future<Either<String, List<ProductModel>>> getWishlist() async {
    final result = await WishlistService.fetchWishList();
    if (result['status_code'] == 200) {
      final wishlist = ProductModel.parseList(result['data']);
      return Right<String, List<ProductModel>>(wishlist);
    }

    return Left<String, List<ProductModel>>(result['message']);
  }

  static Future<Either<String, List<ProductModel>>> addProductToWishlist(
    int productId,
  ) async {
    final result = await WishlistService.addProductToWishlist(productId);
    if (result['status_code'] == 200) {
      final wishlist = ProductModel.parseList(result['data']);
      return Right<String, List<ProductModel>>(wishlist);
    }

    return Left<String, List<ProductModel>>(result['message']);
  }

  static Future<Either<String, List<ProductModel>>> removeProductFromWishlist(
    int productId,
  ) async {
    final result = await WishlistService.removeProductFromWishlist(productId);
    if (result['status_code'] == 200) {
      final wishlist = ProductModel.parseList(result['data']);
      return Right<String, List<ProductModel>>(wishlist);
    }

    return Left<String, List<ProductModel>>(result['message']);
  }
}
