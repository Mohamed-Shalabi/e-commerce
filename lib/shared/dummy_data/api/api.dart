import 'package:e_commerce/shared/dummy_data/database/database_manager.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';

class Api {
  Api._();

  static final DatabaseManager _databaseManager =
      DatabaseManager.getInstance();

  static final Api _instance = Api._();

  factory Api.getInstance() => _instance;

  static Future<void> init() async {
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

  Future<Map<String, dynamic>> searchProducts(
    String searchTerm,
  ) async {
    return _futureRequest(
      () => _databaseManager.searchForProducts(searchTerm),
    );
  }

  Future<Map<String, dynamic>> queryProduct(int productId) async {
    return _futureRequest(() => _databaseManager.queryProduct(productId));
  }

  Future<Map<String, dynamic>> login(String email, String password) {
    return _request(() => _databaseManager.login(email, password));
  }

  Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String country,
    required String city,
    required String address,
  }) {
    return _futureRequest(
      () => _databaseManager.createUser(
        name: name,
        email: email,
        password: password,
        phone: phone,
        country: country,
        city: city,
        address: address,
      ),
    );
  }

  Future<Map<String, dynamic>> logout() {
    return _futureRequest(() => _databaseManager.removeUser());
  }

  Future<Map<String, dynamic>> queryCart() {
    return _futureRequest(() => _databaseManager.queryCart());
  }

  Future<Map<String, dynamic>> addProductToCart(int productId) {
    return _futureRequest(() => _databaseManager.addProductToCart(productId));
  }

  Future<Map<String, dynamic>> removeProductFromCart(int productId) {
    return _futureRequest(
      () => _databaseManager.removeProductFromCart(productId),
    );
  }

  // TODO: Remove discount
  Future<Map<String, dynamic>> applyCoupon(String coupon, double discount) {
    return _futureRequest(
      () => _databaseManager.applyCoupon(coupon, discount),
    );
  }

  Future<Map<String, dynamic>> removeCoupon() {
    return _futureRequest(
      () => _databaseManager.removeCoupon(),
    );
  }

  Future<Map<String, dynamic>> queryWishlist() {
    return _request(() => _databaseManager.queryWishlist());
  }

  Future<Map<String, dynamic>> addProductToWishlist(int productId) {
    return _futureRequest(
      () => _databaseManager.addProductToWishlist(productId),
    );
  }

  Future<Map<String, dynamic>> removeProductFromWishlist(int productId) {
    return _request(
      () => _databaseManager.removeProductFromWishlist(productId),
    );
  }

  Future<Map<String, dynamic>> clearCart() {
    return _futureRequest(
      () => _databaseManager.clearCart(),
    );
  }
}

Future<Map<String, dynamic>> _request<T>(T? Function() getData) async {
  try {
    await Future.delayed(const Duration(seconds: 1));
    if (!await isConnected) {
      throw InternetException(AppStrings.connectionError);
    }

    final data = getData();
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
      'message': e.toString(),
    };
  }
}

Future<Map<String, dynamic>> _futureRequest<T>(
  Future<T?> Function() getData,
) async {
  try {
    await Future.delayed(const Duration(seconds: 1));
    if (!await isConnected) {
      throw InternetException(AppStrings.connectionError);
    }

    final data = await getData();
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
      'message': e.toString(),
    };
  }
}

class RequestException extends BaseException {
  RequestException(super.message);
}

class InternetException extends BaseException {
  InternetException(super.message);
}
