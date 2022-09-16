part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartFetched extends CartState {}

class CartAddOrRemoveProductLoading extends CartState {}

class CartAddOrRemoveProductFailed extends CartState {
  final String message;

  CartAddOrRemoveProductFailed({required this.message});
}

class CartAddOrRemoveProductSucceeded extends CartState {}

class ApplyOrRemoveCouponLoading extends CartState {}

class ApplyOrRemoveCouponSucceeded extends CartState {}

class ApplyOrRemoveCouponFailed extends CartState {
  final String message;

  ApplyOrRemoveCouponFailed({required this.message});
}

class PlaceOrderLoading extends CartState {}

class PlaceOrderSucceeded extends CartState {}

class PlaceOrderFailed extends CartState {
  final String message;

  PlaceOrderFailed({required this.message});
}
