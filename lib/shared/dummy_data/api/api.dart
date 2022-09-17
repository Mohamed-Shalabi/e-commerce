import 'dart:io';

import 'package:e_commerce/shared/dummy_data/database/database_manager.dart';
import 'package:e_commerce/shared/functions/functions.dart';

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

  Future<Map<String, dynamic>> searchForProducts(String searchTerm) async {
    return _futureRequest(
      () => _databaseManager.searchForProducts(searchTerm),
    );
  }

  Future<Map<String, dynamic>> queryProduct(int productId) async {
    return _futureRequest(() => _databaseManager.queryProduct(productId));
  }

  Future<Map<String, dynamic>> login(String email, String password) {
    return _futureRequest(() => _databaseManager.login(email, password));
  }

  Future<Map<String, dynamic>> queryUserProfile(int userToken) {
    return _futureRequest(() => _databaseManager.queryUserProfile(userToken));
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
    return _futureRequest(() => _databaseManager.logout());
  }

  Future<Map<String, dynamic>> queryCart(int userToken) {
    return _futureRequest(() => _databaseManager.queryCart(userToken));
  }

  Future<Map<String, dynamic>> addProductToCart(
    int productId,
    int userToken,
  ) {
    return _futureRequest(
      () => _databaseManager.addProductToCart(productId, userToken),
    );
  }

  Future<Map<String, dynamic>> removeProductFromCart(
    int productId,
    int userToken,
  ) {
    return _futureRequest(
      () => _databaseManager.removeProductFromCart(productId, userToken),
    );
  }

  // TODO: Remove discount
  Future<Map<String, dynamic>> applyCoupon(
    String coupon,
    double discount,
    int userToken,
  ) {
    return _futureRequest(
      () => _databaseManager.applyCoupon(coupon, discount, userToken),
    );
  }

  Future<Map<String, dynamic>> removeCoupon(int userToken) {
    return _futureRequest(
      () => _databaseManager.removeCoupon(userToken),
    );
  }

  Future<Map<String, dynamic>> queryWishlist(int userToken) {
    return _futureRequest(() => _databaseManager.queryWishlist(userToken));
  }

  Future<Map<String, dynamic>> addProductToWishlist(
    int productId,
    int userToken,
  ) {
    return _futureRequest(
      () => _databaseManager.addProductToWishlist(productId, userToken),
    );
  }

  Future<Map<String, dynamic>> removeProductFromWishlist(
    int productId,
    int userToken,
  ) {
    return _futureRequest(
      () => _databaseManager.removeProductFromWishlist(productId, userToken),
    );
  }

  Future<Map<String, dynamic>> placeOrderAndClearCart(int userToken) {
    return _futureRequest(
      () => _databaseManager.placeOrderAndClearCart(userToken),
    );
  }

  Future<Map<String, dynamic>> queryOrders(int userToken) {
    return _futureRequest(
      () => _databaseManager.queryOrders(userToken),
    );
  }
}

Future<Map<String, dynamic>> _futureRequest<T>(
  Future<T?> Function() getData,
) async {
  try {
    await Future.delayed(const Duration(milliseconds: 600));
    if (!await isConnected) {
      throw const SocketException('Check your internet connection');
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
  } catch (e, s) {
    print(e);
    print(s);
    return {
      'status_code': 500,
      'message': e.toString(),
    };
  }
}
