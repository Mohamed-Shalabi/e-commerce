import 'dart:io';

import 'package:e_commerce/core/database/database/database_manager.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';
import 'package:e_commerce/core/functions/functions.dart';

class Api {
  Api._();

  static final DatabaseManager _databaseManager = DatabaseManager.getInstance();

  static final Api _instance = Api._();

  factory Api.getInstance() => _instance;

  static Future<void> init() async {
    await _databaseManager.init();
  }

  Future<FakeHttpResponse> queryCategories() {
    return _futureRequest(() => _databaseManager.queryCategories());
  }

  Future<FakeHttpResponse> queryCategory(int categoryId) {
    return _futureRequest(() => _databaseManager.queryCategory(categoryId));
  }

  Future<FakeHttpResponse> queryCategoryProducts(int categoryId) async {
    return _futureRequest(
      () => _databaseManager.queryCategoryProducts(categoryId),
    );
  }

  Future<FakeHttpResponse> searchForProducts(String searchTerm) async {
    return _futureRequest(
      () => _databaseManager.searchForProducts(searchTerm),
    );
  }

  Future<FakeHttpResponse> queryProduct(int productId) async {
    return _futureRequest(() => _databaseManager.queryProduct(productId));
  }

  Future<FakeHttpResponse> login(String email, String password) {
    return _futureRequest(() => _databaseManager.login(email, password));
  }

  Future<FakeHttpResponse> queryUserProfile(int userToken) {
    return _futureRequest(() => _databaseManager.queryUserProfile(userToken));
  }

  Future<FakeHttpResponse> signUp({
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

  Future<FakeHttpResponse> logout() {
    return _futureRequest(() => _databaseManager.logout());
  }

  Future<FakeHttpResponse> queryCart(int userToken) {
    return _futureRequest(() => _databaseManager.queryCart(userToken));
  }

  Future<FakeHttpResponse> addProductToCart(
    int productId,
    int userToken,
  ) {
    return _futureRequest(
      () => _databaseManager.addProductToCart(productId, userToken),
    );
  }

  Future<FakeHttpResponse> removeProductFromCart(
    int productId,
    int userToken,
  ) {
    return _futureRequest(
      () => _databaseManager.removeProductFromCart(productId, userToken),
    );
  }

  Future<FakeHttpResponse> queryWishlist(int userToken) {
    return _futureRequest(() => _databaseManager.queryWishlist(userToken));
  }

  Future<FakeHttpResponse> addProductToWishlist(
    int productId,
    int userToken,
  ) {
    return _futureRequest(
      () => _databaseManager.addProductToWishlist(productId, userToken),
    );
  }

  Future<FakeHttpResponse> removeProductFromWishlist(
    int productId,
    int userToken,
  ) {
    return _futureRequest(
      () => _databaseManager.removeProductFromWishlist(productId, userToken),
    );
  }

  Future<FakeHttpResponse> placeOrderAndClearCart(int userToken) {
    return _futureRequest(
      () => _databaseManager.placeOrderAndClearCart(userToken),
    );
  }

  Future<FakeHttpResponse> queryOrders(int userToken) {
    return _futureRequest(
      () => _databaseManager.queryOrders(userToken),
    );
  }
}

Future<FakeHttpResponse> _futureRequest<T>(
  Future<String> Function() getData,
) async {
  await Future.delayed(const Duration(milliseconds: 600));
  if (!await isConnected) {
    throw const SocketException('Check your internet connection');
  }

  try {
    final data = await getData();
    return FakeHttpResponse(statusCode: 200, body: data);
  } catch (e, s) {
    print(e);
    print(s);
    return FakeHttpResponse(statusCode: 500, body: e.toString());
  }
}
