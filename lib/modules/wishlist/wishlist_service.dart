import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class WishlistService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> fetchWishList() {
    return _api.queryWishlist();
  }

  static Future<Map<String, dynamic>> addProductToWishlist(
    int productId,
  ) {
    return _api.addProductToWishlist(productId);
  }

  static Future<Map<String, dynamic>> removeProductFromWishlist(
    int productId,
  ) {
    return _api.removeProductFromWishlist(productId);
  }
}
