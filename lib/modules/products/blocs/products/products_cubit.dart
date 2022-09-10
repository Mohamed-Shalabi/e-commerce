import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/products/products_repository.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required this.category}) : super(ProductsInitial());

  Future<void> getProducts() async {
    emit(ProductsLoading());
    try {
      emit(ProductsLoading());
      final products = await ProductsRepository.getCategoryProducts(
        category.id,
      );
      emit(ProductsFetched(products: products));
    } on BaseException catch (e) {
      emit(ProductsFetchError(message: e.message));
    }
  }

  final CategoryModel category;
}
