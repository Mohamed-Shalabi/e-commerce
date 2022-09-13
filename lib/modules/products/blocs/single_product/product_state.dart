part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class AddOrRemoveProductLoading extends ProductState {}

class AddOrRemoveProductFailed extends ProductState {
  final String message;

  AddOrRemoveProductFailed({required this.message});
}

class AddOrRemoveProductSucceeded extends ProductState {}
