part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartAddOrRemoveProductLoading extends CartState {}

class CartAddOrRemoveProductFailed extends CartState {
  final String message;

  CartAddOrRemoveProductFailed({required this.message});
}

class CartAddOrRemoveProductSucceeded extends CartState {}
