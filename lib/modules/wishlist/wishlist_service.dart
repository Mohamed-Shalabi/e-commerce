import 'package:e_commerce/shared/dummy_data/api/api.dart';
import 'package:e_commerce/shared/local/prefs.dart';

abstract class WishlistService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> fetchWishList() {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.queryWishlist(userToken);
  }

  static Future<Map<String, dynamic>> addProductToWishlist(
    int productId,
  ) {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.addProductToWishlist(productId, userToken);
  }

  static Future<Map<String, dynamic>> removeProductFromWishlist(
    int productId,
  ) {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.removeProductFromWishlist(productId, userToken);
  }
}
