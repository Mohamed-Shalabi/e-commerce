import 'package:e_commerce/shared/dummy_data/database/database_manager.dart';

class Api {
  Api._();

  static final DatabaseManager _databaseManager =
      DatabaseManager.getInstance();

  static final Api _instance = Api._();

  factory Api.getInstance() => _instance;

  static Future<void> initialize() async {
    await _databaseManager.init();
  }

  Future<Map<String, dynamic>> queryCategories() {
    return _futureRequest(() => _databaseManager.queryCategories());
  }

  Future<Map<String, dynamic>> queryCategory(int categoryId) {
    return _futureRequest(() => _databaseManager.queryCategory(categoryId));
  }

  Future<Map<String, dynamic>> queryCategoryProducts(
    int categoryId,
  ) async {
    return _futureRequest(
      () => _databaseManager.queryCategoryProducts(categoryId),
    );
  }

  Future<Map<String, dynamic>> queryProduct(int productId) async {
    return _futureRequest(() => _databaseManager.queryProduct(productId));
  }

  Map<String, dynamic> queryUser() {
    return _request(() => _databaseManager.queryUser());
  }

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> user) {
    return _futureRequest(() => _databaseManager.createUser(user));
  }

  Future<Map<String, dynamic>> logout() {
    return _futureRequest(() => _databaseManager.removeUser());
  }

  Map<String, dynamic> queryCart() {
    return _request(() => _databaseManager.queryCart());
  }

  Future<Map<String, dynamic>> addProductToCart(int productId) {
    return _futureRequest(() => _databaseManager.addProductToCart(productId));
  }

  Future<Map<String, dynamic>> removeProductFromCart(int productId) {
    return _futureRequest(
      () => _databaseManager.removeProductFromCart(productId),
    );
  }

  Map<String, dynamic> applyCoupon(String coupon, double discount) {
    return _request(() => _databaseManager.applyCoupon(coupon, discount));
  }

  Map<String, dynamic> queryWishlist() {
    return _request(() => _databaseManager.queryWishlist());
  }

  Future<Map<String, dynamic>> addProductToWishlist(int productId) {
    return _futureRequest(
      () => _databaseManager.addProductToWishlist(productId),
    );
  }

  Map<String, dynamic> removeProductFromWishlist(int productId) {
    return _request(
      () => _databaseManager.removeProductFromWishlist(productId),
    );
  }
}

Map<String, dynamic> _request<T>(T? Function()? getData) {
  try {
    final data = getData!();
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
  } catch (e) {
    return {
      'status_code': 500,
      'message': 'an error occurred',
    };
  }
}

Future<Map<String, dynamic>> _futureRequest<T>(
  Future<T>? Function()? getData,
) async {
  try {
    final data = await getData!();

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
  } catch (e) {
    return {
      'status_code': 500,
      'message': 'an error occurred',
    };
  }
}
