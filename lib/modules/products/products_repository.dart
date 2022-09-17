import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/products/products_service.dart';

abstract class ProductsRepository {
  static Future<Either<String, List<ProductListModel>>> getCategoryProducts(
    int categoryId,
  ) async {
    final result = await ProductsService.fetchCategoryProducts(categoryId);
    if (result['status_code'] == 200) {
      final products = ProductListModel.parseList(result['data']);
      return Right<String, List<ProductListModel>>(products);
    }

    return Left<String, List<ProductListModel>>(result['message']);
  }

  static Future<Either<String, ProductData>> getProductData(
    int productId,
    int categoryId,
  ) async {
    final results = await Future.wait([
      ProductsService.fetchProduct(productId),
      ProductsService.fetchCategoryProducts(categoryId),
    ]);

    if (results[0]['status_code'] == 200 && results[1]['status_code'] == 200) {
      final product = ProductModel.fromMap(results[0]['data']);
      final similarProducts = ProductListModel.parseList(results[1]['data']);
      return Right<String, ProductData>(
        ProductData(
          product: product,
          similarProducts: similarProducts,
        ),
      );
    }

    if (results[0]['status_code'] == 500) {
      return Left<String, ProductData>(results[0]['message']);
    }

    return Left<String, ProductData>(results[1]['message']);
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
