import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/search/search_service.dart';

abstract class SearchRepository {
  static Future<Either<String, List<ProductListModel>>> searchForProducts(
    String searchTerm,
  ) async {
    final result = await SearchService.searchForProducts(searchTerm);
    if (result['status_code'] == 200) {
      return Right<String, List<ProductListModel>>(
        ProductListModel.parseList(result['data']),
      );
    }

    return Left<String, List<ProductListModel>>(result['message']);
  }
}
