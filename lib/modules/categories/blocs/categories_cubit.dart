import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/modules/categories/categories_repository.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void getCategories() async {
    try {
      emit(CategoriesLoading());
      final categories = await CategoriesRepository.getCategories();
      emit(CategoriesFetched(categories));
    } on BaseException catch (e) {
      emit(CategoriesFetchError(e.message));
    }
  }
}
