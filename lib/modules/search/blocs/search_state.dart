part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchDone extends SearchState {
  final List<ProductModel> products;

  SearchDone(this.products);
}

class SearchFailed extends SearchState {
  final String message;

  SearchFailed(this.message);
}
