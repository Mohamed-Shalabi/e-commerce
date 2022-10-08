import 'package:e_commerce/core/database/api/api.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/local/prefs.dart';

abstract class WishlistService {
  static final _api = Api.getInstance();

  static Future<FakeHttpResponse> fetchWishList() {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.queryWishlist(userToken);
  }

  static Future<FakeHttpResponse> addProductToWishlist(
    int productId,
  ) {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.addProductToWishlist(productId, userToken);
  }

  static Future<FakeHttpResponse> removeProductFromWishlist(
    int productId,
  ) {
    final userToken = Prefs.getData<int>(key: Prefs.userTokenKey)!;
    return _api.removeProductFromWishlist(productId, userToken);
  }
}
