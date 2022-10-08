import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/modules/my_orders/my_orders_service.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';

abstract class MyOrdersRepository {
  static Future<Either<String, List<OrderModel>>> getMyOrders() async {
    try {
      final result = await MyOrdersService.fetchMyOrders();
      if (result['status_code'] == 200) {
        final jsonData =
            json.decode(result['data']).cast<Map<String, dynamic>>();
        final wishlist = OrderModel.parseList(jsonData);
        return Right<String, List<OrderModel>>(wishlist);
      }

      return Left<String, List<OrderModel>>(result['message']);
    } on SocketException {
      return const Left<String, List<OrderModel>>(AppStrings.connectionError);
    } catch (_, __) {
      print(_);
      print(__);
      return const Left<String, List<OrderModel>>(AppStrings.unknownError);
    }
  }
}
