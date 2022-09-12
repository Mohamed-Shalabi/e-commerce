import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/modules/products/blocs/products/base_products_cubit.dart';
import 'package:e_commerce/modules/products/products_repository.dart';
import 'package:flutter/material.dart';

part 'products_state.dart';

class ProductsCubit extends BaseProductsCubit<ProductsState> {
  ProductsCubit({required this.category}) : super(ProductsInitial());

  Future<void> getProducts() async {
    emit(ProductsLoading());

    emit(ProductsLoading());
    final result = await ProductsRepository.getCategoryProducts(category.id);

    result.fold<void>(
      (l) => emit(ProductsFetchError(message: l)),
      (r) {
        products = r;
        emit(ProductsFetched());
      },
    );
  }

  final CategoryModel category;
}
