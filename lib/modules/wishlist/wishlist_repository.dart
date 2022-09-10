import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/wishlist/wishlist_service.dart';
import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class WishlistRepository {
  static Future<List<ProductModel>> getWishlist() async {
    final result = await WishlistService.fetchWishList();
    if (result['status_code'] == 200) {
      final wishlist = ProductModel.parseList(result['data']);
      return wishlist;
    }

    throw RequestException(result['message']);
  }

  static Future<List<ProductModel>> addProductToWishlist(
    int productId,
  ) async {
    final result = await WishlistService.addProductToWishlist(productId);
    if (result['status_code'] == 200) {
      final wishlist = ProductModel.parseList(result['data']);
      return wishlist;
    }

    throw RequestException(result['message']);
  }

  static Future<List<ProductModel>> removeProductFromWishlist(
    int productId,
  ) async {
    final result = await WishlistService.removeProductFromWishlist(productId);
    if (result['status_code'] == 200) {
      final wishlist = ProductModel.parseList(result['data']);
      return wishlist;
    }

    throw RequestException(result['message']);
  }
}
