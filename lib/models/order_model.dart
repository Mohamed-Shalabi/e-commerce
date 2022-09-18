import 'package:e_commerce/models/product_model.dart';

class OrderListModel {
  final int id;
  final double total;
  final List<ProductListModel> products;

  OrderListModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        total = map['total'],
        products = ProductListModel.parseList(map['products']);
}
