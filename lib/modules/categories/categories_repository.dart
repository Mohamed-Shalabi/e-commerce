import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/modules/categories/categories_service.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';

abstract class CategoriesRepository {
  static Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final result = await CategoriesService.getCategories();

      if (result['status_code'] == 200) {
        final data = json.decode(result['data']).cast<Map<String, dynamic>>();
        return Right<String, List<CategoryModel>>(
          CategoryModel.parseList(data),
        );
      }

      return Left<String, List<CategoryModel>>(result['message']);
    } on SocketException {
      return const Left<String, List<CategoryModel>>(
        AppStrings.connectionError,
      );
    } catch (_) {
      return const Left<String, List<CategoryModel>>(AppStrings.unknownError);
    }
  }
}
