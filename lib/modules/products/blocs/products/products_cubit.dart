import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/modules/products/blocs/products/base_products_cubit.dart';
import 'package:e_commerce/modules/products/products_repository.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:flutter/material.dart';

part 'products_state.dart';

class ProductsCubit extends BaseProductsCubit<ProductsState> {
  ProductsCubit({required this.category}) : super(ProductsInitial());

  Future<void> getProducts() async {
    emit(ProductsLoading());
    try {
      emit(ProductsLoading());
      products = await ProductsRepository.getCategoryProducts(
        category.id,
      );
      emit(ProductsFetched());
    } on BaseException catch (e) {
      emit(ProductsFetchError(message: e.message));
    }
  }

  final CategoryModel category;
}
