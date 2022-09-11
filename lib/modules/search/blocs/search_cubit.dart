import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/search/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchForProducts(String searchTerm) async {
    try {
      emit(SearchLoading());
      final products = await SearchRepository.searchForProducts(searchTerm);
      emit(SearchDone(products));
    } catch(e) {
      emit(SearchFailed(e.toString()));
    }
  }

  void clearSearchResults(String trim) {
    emit(SearchDone([]));
  }
}
