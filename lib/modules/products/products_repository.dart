import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/products/products_service.dart';
import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class ProductsRepository {
  static Future<List<ProductModel>> getCategoryProducts(int categoryId) async {
    final result = await ProductsService.fetchCategoryProducts(categoryId);
    if (result['status_code'] == 200) {
      final products = ProductModel.parseList(result['data']);
      return products;
    }

    throw RequestException(result['message']);
  }
}
