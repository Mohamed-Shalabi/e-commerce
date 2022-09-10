import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/modules/categories/categories_service.dart';
import 'package:e_commerce/shared/dummy_data/api/api.dart';

abstract class CategoriesRepository {
  static Future<List<CategoryModel>> getCategories() async {
    final result = await CategoriesService.getCategories();

    if (result['status_code'] == 200) {
      return CategoryModel.parseList(result['data']);
    }

    throw RequestException(result['message']);
  }
}
