import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/products/products_service.dart';

abstract class ProductsRepository {
  static Future<Either<String, List<ProductModel>>> getCategoryProducts(
    int categoryId,
  ) async {
    final result = await ProductsService.fetchCategoryProducts(categoryId);
    if (result['status_code'] == 200) {
      final products = ProductModel.parseList(result['data']);
      return Right<String, List<ProductModel>>(products);
    }

    return Left<String, List<ProductModel>>(result['message']);
  }
}
