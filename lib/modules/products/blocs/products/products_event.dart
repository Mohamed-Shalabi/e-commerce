part of 'products_cubit.dart';

abstract class ProductsEvent {}

class ProductsInitialEvent extends ProductsEvent{
  final List<ProductModel> wishlist;

  ProductsInitialEvent({required this.wishlist});
}
