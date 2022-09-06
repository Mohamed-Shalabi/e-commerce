import 'package:e_commerce/shared/dummy_data/database/database_manager.dart';

class Api {
  static final DatabaseManager databaseManager = DatabaseManager.getInstance();

  static Future<void> initialize() async {
    await databaseManager.init();
  }

  Future<Map<String, dynamic>> queryCategories() {
    return _futureRequest(databaseManager.queryCategories());
  }

  Future<Map<String, dynamic>> queryCategory(int categoryId) {
    return _futureRequest(databaseManager.queryCategory(categoryId));
  }

  Future<Map<String, dynamic>> queryCategoryProducts(
    int categoryId,
  ) async {
    return _futureRequest(databaseManager.queryCategoryProducts(categoryId));
  }

  Future<Map<String, dynamic>> queryProduct(int productId) async {
    return _futureRequest(databaseManager.queryProduct(productId));
  }

  Map<String, dynamic> queryUser() {
    return _request(databaseManager.queryUser());
  }

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> user) {
    return _futureRequest(databaseManager.createUser(user));
  }

  Future<Map<String, dynamic>> logout() {
    return _futureRequest(databaseManager.removeUser());
  }

  Map<String, dynamic> queryCart() {
    return _request(databaseManager.queryCart());
  }

  Future<Map<String, dynamic>> addProductToCart(int productId) {
    return _futureRequest(databaseManager.addProductToCart(productId));
  }

  Future<Map<String, dynamic>> removeProductFromCart(int productId) {
    return _futureRequest(databaseManager.removeProductFromCart(productId));
  }

  Map<String, dynamic> applyCoupon(String coupon, double discount) {
    return _request(databaseManager.applyCoupon(coupon, discount));
  }

  Map<String, dynamic> queryWishlist() {
    return _request(databaseManager.queryWishlist());
  }

  Future<Map<String, dynamic>> addProductToWishlist(int productId) {
    return _futureRequest(databaseManager.addProductToWishlist(productId));
  }

  Map<String, dynamic> removeProductFromWishlist(int productId) {
    return _request(databaseManager.removeProductFromWishlist(productId));
  }
}

Map<String, dynamic> _request<T>(T? data) {
  if (data == null) {
    return {
      'status_code': 500,
      'message': 'an error occurred',
    };
  } else {
    return {
      'status_code': 200,
      'data': data,
    };
  }
}

Future<Map<String, dynamic>> _futureRequest<T>(Future<T>? data) async {
  if (data == null) {
    return {
      'status_code': 500,
      'message': 'an error occurred',
    };
  }

  try {
    final result = await data;

    if (result == null) {
      return {
        'status_code': 500,
        'message': 'an error occurred',
      };
    } else {
      return {
        'status_code': 200,
        'data': data,
      };
    }
  } catch (e) {
    return {
      'status_code': 500,
      'message': 'an error occurred',
    };
  }
}
