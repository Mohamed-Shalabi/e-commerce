import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class CategoriesService {
  static final _api = Api.getInstance();

  static Future<Map<String, dynamic>> getCategories() {
    return _api.queryCategories();
  }
}
