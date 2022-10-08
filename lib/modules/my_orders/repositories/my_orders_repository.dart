import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/my_orders/models/order_model.dart';
import 'package:e_commerce/modules/my_orders/services/my_orders_service.dart';

abstract class MyOrdersRepository {
  static Future<Either<String, List<OrderModel>>> getMyOrders() async {
    try {
      final result = await MyOrdersService.fetchMyOrders();
      if (result.statusCode == 200) {
        final jsonData =
            json.decode(result.body).cast<Map<String, dynamic>>();
        final wishlist = OrderModel.parseList(jsonData);
        return Right<String, List<OrderModel>>(wishlist);
      }

      return Left<String, List<OrderModel>>(result.body);
    } on SocketException {
      return const Left<String, List<OrderModel>>(AppStrings.connectionError);
    } catch (_, __) {
      print(_);
      print(__);
      return const Left<String, List<OrderModel>>(AppStrings.unknownError);
    }
  }
}
