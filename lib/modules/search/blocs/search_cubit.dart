import 'package:e_commerce/modules/products/models/product_model.dart';
import 'package:e_commerce/modules/search/repositories/search_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchForProducts(String searchTerm) async {
    emit(SearchLoading());
    final result = await SearchRepository.searchForProducts(searchTerm);
    result.fold<void>(
      (l) => emit(SearchFailed(l)),
      (r) => emit(SearchDone(r)),
    );
  }

  void clearSearchResults(String trim) {
    emit(SearchDone(const []));
  }
}
