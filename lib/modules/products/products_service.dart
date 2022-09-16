import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class ProductsService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> fetchCategoryProducts(int categoryId) {
    return _api.queryCategoryProducts(categoryId);
  }

  static Future<Map<String, dynamic>> fetchProduct(int productId) {
    return _api.queryProduct(productId);
  }
}
