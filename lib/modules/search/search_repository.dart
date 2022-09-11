import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/search/search_service.dart';
import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class SearchRepository {
  static Future<List<ProductModel>> searchForProducts(
    String searchTerm,
  ) async {
    final result = await SearchService.searchForProducts(searchTerm);
    if (result['status_code'] == 200) {
      return ProductModel.parseList(result['data']);
    }

    throw RequestException(result['message']);
  }
}
