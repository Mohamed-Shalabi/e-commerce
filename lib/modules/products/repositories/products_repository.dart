import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/products/models/product_model.dart';
import 'package:e_commerce/modules/products/services/products_service.dart';

abstract class ProductsRepository {
  static Future<Either<String, List<ProductListModel>>> getCategoryProducts(
    int categoryId,
  ) async {
    try {
      final result = await ProductsService.fetchCategoryProducts(categoryId);
      if (result.statusCode == 200) {
        final data = json.decode(result.body).cast<Map<String, dynamic>>();
        final products = ProductListModel.parseList(data);
        return Right<String, List<ProductListModel>>(products);
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

  static Future<Either<String, ProductData>> getProductData(
    int productId,
    int categoryId,
  ) async {
    try {
      final results = await Future.wait([
        ProductsService.fetchProduct(productId),
        ProductsService.fetchCategoryProducts(categoryId),
      ]);

      if (results[0].statusCode == 200 &&
          results[1].statusCode == 200) {
        final productData = json.decode(results[0].body);
        final product = ProductModel.fromMap(productData);
        final similarProductsData =
            json.decode(results[1].body).cast<Map<String, dynamic>>();
        final similarProducts = ProductListModel.parseList(similarProductsData);
        return Right<String, ProductData>(
          ProductData(
            product: product,
            similarProducts: similarProducts,
          ),
        );
      }

      if (results[0].statusCode == 500) {
        return Left<String, ProductData>(results[0].body);
      }

      return Left<String, ProductData>(results[1].body);
    } on SocketException {
      return const Left<String, ProductData>(AppStrings.connectionError);
    } catch (_) {
      return const Left<String, ProductData>(AppStrings.unknownError);
    }
  }
}

class ProductData {
  final ProductModel product;
  final List<ProductListModel> similarProducts;

  ProductData({
    required this.product,
    required this.similarProducts,
  });
}
