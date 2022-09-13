part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartFetched extends CartState {}

class CartAddOrRemoveProductSucceeded extends CartState {}

class ApplyOrRemoveCouponLoading extends CartState {}

class ApplyOrRemoveCouponSucceeded extends CartState {}

class ApplyOrRemoveCouponFailed extends CartState {
  final String message;

  ApplyOrRemoveCouponFailed({required this.message});
}

class ClearCartLoading extends CartState {}

class ClearCartSucceeded extends CartState {}

class ClearCartFailed extends CartState {
  final String message;

  ClearCartFailed({required this.message});
}
