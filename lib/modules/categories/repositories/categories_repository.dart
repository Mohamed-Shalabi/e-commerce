import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/categories/categories/category_model.dart';
import 'package:e_commerce/modules/categories/services/categories_service.dart';

abstract class CategoriesRepository {
  static Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final result = await CategoriesService.getCategories();

      if (result.statusCode == 200) {
        final data = json.decode(result.body).cast<Map<String, dynamic>>();
        return Right<String, List<CategoryModel>>(
          CategoryModel.parseList(data),
        );
      }

      return Left<String, List<CategoryModel>>(result.body);
    } on SocketException {
      return const Left<String, List<CategoryModel>>(
        AppStrings.connectionError,
      );
    } catch (_) {
      return const Left<String, List<CategoryModel>>(AppStrings.unknownError);
    }
  }
}
