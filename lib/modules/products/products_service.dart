import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class ProductsService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> fetchCategoryProducts(int categoryId) {
    return _api.queryCategoryProducts(categoryId);
  }
}
