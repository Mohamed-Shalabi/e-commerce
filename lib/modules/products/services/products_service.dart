import 'package:e_commerce/core/database/api/api.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';

abstract class ProductsService {
  static final _api = Api.getInstance();

  static Future<FakeHttpResponse> fetchCategoryProducts(int categoryId) {
    return _api.queryCategoryProducts(categoryId);
  }

  static Future<FakeHttpResponse> fetchProduct(int productId) {
    return _api.queryProduct(productId);
  }
}
