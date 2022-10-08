import 'package:e_commerce/modules/my_orders/models/order_model.dart';
import 'package:e_commerce/modules/my_orders/repositories/my_orders_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitial());

  late final List<OrderModel> orders;

  void getOrders() async {
    final result = await MyOrdersRepository.getMyOrders();

    result.fold<void>(
      (l) => emit(MyOrdersFetchFailed(message: l)),
      (r) {
        orders = r;
        emit(MyOrdersFetchDone());
      },
    );
  }
}
