import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class SearchService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> searchForProducts(String searchTerm) {
    return _api.searchProducts(searchTerm);
  }
}
