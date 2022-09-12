import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/shared/functions/functions.dart';

class ProductModel {
  final int id;
  final String title, description;
  final List<String> images;
  final double price;
  final int quantity;
  final List<String> components;

  ProductModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'] ?? '',
        images = ((map['images']) as String).toJson.cast<String>(),
        price = map['price'],
        quantity = map['quantity'] ?? 0,
        components =
            ((map['components'] ?? '[]') as String).toJson.cast<String>() ??
                [];

  String get quantityAsString {
    if (quantity == 0) {
      return 'Out of stock';
    }

    if (quantity < 4) {
      return '$quantity only available!';
    }

    if (quantity < 11) {
      return '$quantity available';
    }

    return 'Available';
  }

  bool isInWishlist(List<ProductModel> wishlist) {
    return wishlist.any((element) => element.id == id);
  }

  bool get isInCart => CartModel.getInstance().containsProduct(this);

  int get quantityInCart => CartModel.getInstance().numberOfProduct(this);

  double get totalPriceInCart => quantityInCart * price;

  static List<ProductModel> parseList(List<Map<String, dynamic>> list) {
    return list.map((map) => ProductModel.fromMap(map)).toList();
  }
}
