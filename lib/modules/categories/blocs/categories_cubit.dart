import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/modules/categories/categories_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void getCategories() async {
    emit(CategoriesLoading());
    final result = await CategoriesRepository.getCategories();

    result.fold<void>(
      (l) => emit(CategoriesFetchError(l)),
      (r) => emit(CategoriesFetched(r)),
    );
  }
}
