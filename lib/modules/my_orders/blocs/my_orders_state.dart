part of 'my_orders_cubit.dart';

@immutable
abstract class MyOrdersState {}

class MyOrdersInitial extends MyOrdersState {}

class MyOrdersFetchLoading extends MyOrdersState {}

class MyOrdersFetchDone extends MyOrdersState {}

class MyOrdersFetchFailed extends MyOrdersState {
  final String message;

  MyOrdersFetchFailed({required this.message});
}
