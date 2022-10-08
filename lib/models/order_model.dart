import 'dart:developer';

import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/shared/functions/functions.dart';

class OrderModel {
  final int id;
  final DateTime _date;
  final double total;
  final Map<ProductListModel, int> products;

  OrderModel.fromMap({required Map<String, dynamic> map})
      : id = map['id'],
        _date = parseDate(map['date']),
        total = map['total'],
        products = {
          for (final product in map['products'])
            ProductListModel.fromMap(product): product['count'],
        } {
    log(map.toString());
  }

  String get formattedDate => _date.formatted;

  static List<OrderModel> parseList(List<Map<String, dynamic>> list) {
    return list.map((map) => OrderModel.fromMap(map: map)).toList();
  }
}
