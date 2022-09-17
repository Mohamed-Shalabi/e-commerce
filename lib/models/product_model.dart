import 'dart:convert';

import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:equatable/equatable.dart';

abstract class BaseProductModel extends Equatable
    implements ProductModelCartInterface, ProductModelWishlistInterface {
  final int id, categoryId, quantity;
  final double price;
  final String title;

  BaseProductModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        categoryId = map['category_id'],
        title = map['title'],
        price = map['price'],
        quantity = map['quantity'] ?? 0;

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

  @override
  bool isInWishlist(Iterable<ProductListModel> wishlist) {
    return wishlist.any((element) => element.id == id);
  }

  @override
  bool get isInCart => CartModel.getInstance().containsProduct(this);

  @override
  int get quantityInCart => CartModel.getInstance().numberOfProduct(this);

  @override
  double get totalPriceInCart => quantityInCart * price;

  Map<String, dynamic> get toMap => {
        'id': id,
        'category_id': categoryId,
        'quantity': quantity,
        'price': price,
        'title': title,
      };

  @override
  List<Object?> get props => [id];
}

abstract class ProductModelCartInterface {
  bool get isInCart;

  int get quantityInCart;

  double get totalPriceInCart;
}

abstract class ProductModelWishlistInterface {
  bool isInWishlist(Iterable<ProductListModel> wishlist);
}

class ProductListModel extends BaseProductModel {
  final String mainImage;

  ProductListModel.fromMap(Map<String, dynamic> map)
      : mainImage = map['main_image'],
        super.fromMap(map);

  ProductListModel._fromProductModel(ProductModel product)
      : mainImage = product.images.first,
        super.fromMap(product.toMap);

  static List<ProductListModel> parseList(List<Map<String, dynamic>> list) {
    return list.map((map) => ProductListModel.fromMap(map)).toList();
  }

  @override
  Map<String, dynamic> get toMap => {
    ...super.toMap,
    'main_image': mainImage,
  };
}

class ProductModel extends BaseProductModel {
  final String description;
  final List<String> images;
  final List<String> components;

  ProductModel.fromMap(Map<String, dynamic> map)
      : description = map['description'] ?? '',
        images = ((map['images']) as String).toJson.cast<String>(),
        components =
            ((map['components'] ?? '[]') as String).toJson.cast<String>() ??
                [],
        super.fromMap(map);

  ProductListModel get asProductListModel {
    return ProductListModel._fromProductModel(this);
  }

  static List<ProductModel> parseList(List<Map<String, dynamic>> list) {
    return list.map((map) => ProductModel.fromMap(map)).toList();
  }

  @override
  Map<String, dynamic> get toMap => {
    ...super.toMap,
    'description': description,
    'images': json.encode(images),
    'components': json.encode(components),
  };
}
