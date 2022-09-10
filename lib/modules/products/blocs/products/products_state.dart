part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsFetched extends ProductsState {
  final List<ProductModel> products;

  ProductsFetched({required this.products});
}

class ProductsFetchError extends ProductsState {
  final String message;

  ProductsFetchError({required this.message});
}

class ProductsGotWishlist extends ProductsState {}
