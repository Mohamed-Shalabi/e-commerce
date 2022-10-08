import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/cart/cart_repository.dart';
import 'package:e_commerce/modules/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required this.category}) : super(ProductsInitial()) {
    CartRepository.listenToPlaceOrderStream((event) {
      if (!isClosed) {
        getProducts();
      }
    });
  }

  final CategoryModel category;
  List<ProductListModel> products = [];

  Future<void> getProducts() async {
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
}
