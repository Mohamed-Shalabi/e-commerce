import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/modules/categories/categories_service.dart';

abstract class CategoriesRepository {
  static Future<Either<String, List<CategoryModel>>> getCategories() async {
    final result = await CategoriesService.getCategories();

    if (result['status_code'] == 200) {
      return Right<String, List<CategoryModel>>(
        CategoryModel.parseList(result['data']),
      );
    }

    return Left<String, List<CategoryModel>>(result['message']);
  }
}
