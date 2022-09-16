part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class GetProductLoading extends ProductState {}

class GetProductDone extends ProductState {}

class GetProductFailed extends ProductState {
  final String message;

  GetProductFailed({required this.message});
}
