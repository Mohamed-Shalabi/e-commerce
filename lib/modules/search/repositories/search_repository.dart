import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/products/models/product_model.dart';
import 'package:e_commerce/modules/search/services/search_service.dart';

abstract class SearchRepository {
  static Future<Either<String, List<ProductListModel>>> searchForProducts(
    String searchTerm,
  ) async {
    try {
      final result = await SearchService.searchForProducts(searchTerm);
      if (result.statusCode == 200) {
        final jsonData = json.decode(result.body);
        return Right<String, List<ProductListModel>>(
          ProductListModel.parseList(jsonData),
        );
      }

      return Left<String, List<ProductListModel>>(result.body);
    } on SocketException {
      return const Left<String, List<ProductListModel>>(
        AppStrings.connectionError,
      );
    } catch (_) {
      return const Left<String, List<ProductListModel>>(
        AppStrings.unknownError,
      );
    }
  }
}
