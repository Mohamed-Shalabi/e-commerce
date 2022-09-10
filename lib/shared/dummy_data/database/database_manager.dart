import 'dart:convert';
import 'dart:io';

import 'package:e_commerce/shared/dummy_data/api/api.dart';
import 'package:e_commerce/shared/dummy_data/data/cart.dart';
import 'package:e_commerce/shared/dummy_data/data/category.dart';
import 'package:e_commerce/shared/dummy_data/data/product.dart';
import 'package:e_commerce/shared/local/prefs.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._();

  static final DatabaseManager _instance = DatabaseManager._();
  static const String _databaseName = 'app_database.db';
  static const String _categoriesTableName = 'Categories';
  static const String _productsTableName = 'Products';

  factory DatabaseManager.getInstance() => _instance;

  late final Database? _database;

  Future<void> init() async {
    final path = Platform.isIOS
        ? (await getLibraryDirectory()).path
        : await getDatabasesPath();
    _database = await openDatabase(
      p.join(path, _databaseName),
      version: 1,
      onCreate: (database, version) async {
        _createProductsTable(database);
        _createCategoriesTable(database);
        _createCart();
        _createWishlist();
        await _fillCategories(database);
        await _fillProducts(database);
      },
    );
  }

  Future<void> _createProductsTable([Database? db]) async {
    final database = db ?? _database!;
    return database.execute(
      'CREATE TABLE $_productsTableName ('
      'id INTEGER PRIMARY KEY, '
      'title TEXT NOT NULL, '
      'description TEXT NOT NULL, '
      'images TEXT NOT NULL, '
      'price DOUBLE NOT NULL, '
      'quantity INTEGER NOT NULL DEFAULT(1), '
      'components TEXT NOT NULL, '
      'category_id INTEGER NOT NULL'
      ')',
    );
  }

  Future<void> _createCategoriesTable([Database? db]) async {
    final database = db ?? _database!;
    return database.execute(
      'CREATE TABLE $_categoriesTableName ('
      'id INTEGER PRIMARY KEY, '
      'name TEXT NOT NULL'
      ')',
    );
  }

  Future<Map<String, dynamic>?> createUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String country,
    required String city,
    required String address,
  }) async {
    final user = {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'country': country,
      'city': city,
      'address': address,
    };

    final isDone = await Prefs.saveOrRemoveData<String>(
      key: 'user_key',
      value: jsonEncode(user),
    );

    if (isDone) {
      return user;
    }

    throw RequestException('Could not save user');
  }

  Future<String> removeUser() async {
    final isDone = await Prefs.saveOrRemoveData<String>(key: 'user_key');
    if (isDone) {
      return 'done';
    }

    throw RequestException('Could not log out');
  }

  Future<bool> _createCart([Map<String, dynamic>? cart]) {
    cart ??= cartData;

    if (cart['total'] < 0) {
      cart = cartData;
    }

    return Prefs.saveOrRemoveData<String>(
      key: 'cart_key',
      value: jsonEncode(cart),
    );
  }

  Future<bool> _createWishlist([List<Map<String, dynamic>>? wishlist]) {
    wishlist ??= wishlistData;
    return Prefs.saveOrRemoveData<String>(
      key: 'wishlist_key',
      value: jsonEncode(wishlist),
    );
  }

  Future<void> _fillProducts([Database? database]) async {
    database ??= _database;
    for (final product in allProductsData) {
      await database?.insert(_productsTableName, product);
    }
  }

  Future<void> _fillCategories([Database? database]) async {
    database ??= _database;
    for (final category in allCategoriesData) {
      await database?.insert(_categoriesTableName, category);
    }
  }

  Future<List<Map<String, Object?>>?> queryCategories() {
    if (_database == null) {
      throw RequestException('Error in database');
    }
    return _database!.query(_categoriesTableName);
  }

  Future<Map<String, Object?>?> queryCategory(int categoryId) {
    if (_database == null) {
      throw RequestException('Error in database');
    }

    return _database!.query(
      _categoriesTableName,
      where: 'id = ?',
      whereArgs: [categoryId],
    ).then((value) {
      return value.first;
    });
  }

  Future<List<Map<String, Object?>>?> queryCategoryProducts(
    int categoryId,
  ) async {
    if (_database == null) {
      throw RequestException('Error in database');
    }

    return await _database!.query(
      _productsTableName,
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
  }

  Future<Map<String, Object?>?> queryProduct(int productId) async {
    if (_database == null) {
      throw RequestException('Error in database');
    }

    final result = await _database!.query(
      _productsTableName,
      where: 'id = ?',
      whereArgs: [productId],
    );

    if (result.isEmpty) {
      throw RequestException('Product not found');
    }

    return result.first;
  }

  Map<String, dynamic> login(String email, String password) {
    final jsonString = Prefs.getData<String>(key: 'user_key') ?? '{}';
    final result = json.decode(jsonString);
    if (result['email'] == email && result['password'] == password) {
      return result;
    }

    throw RequestException('Wrong email or password');
  }

  Future<Map<String, dynamic>> queryCart() async {
    final jsonString = Prefs.getData<String>(key: 'cart_key')!;
    final cart = json.decode(jsonString);
    final products = <Map<String, dynamic>>[];
    for (final productId in cart['products'].map((e) => e['id'])) {
      final product =
          (await queryProduct(productId))?.cast<String, dynamic>() ?? {};
      if (product.isNotEmpty) {
        products.add(product);
      }
    }
    cart['products'] = products;
    return cart;
  }

  Future<Map<String, dynamic>> addProductToCart(int productId) async {
    final product = await queryProduct(productId);
    final cart = await queryCart();

    final cartProductQuantity = cart['products']
        .cast<Map<String, dynamic>>()
        .where((element) => element['id'] == productId)
        .length;
    if (cartProductQuantity >= (product!['quantity'] as int)) {
      throw RequestException('Cannot add more');
    }

    cart['products'].add(product);
    cart['total'] += product['price'];
    _createCart(cart);
    return cart;
  }

  Future<Map<String, dynamic>> removeProductFromCart(int productId) async {
    final product = await queryProduct(productId);
    final cart = await queryCart();
    final cartProducts = (cart['products'] as List<Map<String, dynamic>>);
    final index = cartProducts.indexWhere(
      (element) => element['id'] == product!['id'],
    );
    if (index != -1) {
      cartProducts.removeAt(index);
      cart['total'] -= product!['price'];
      _createCart(cart);
    } else {
      throw RequestException('Could not remove from cart');
    }
    return cart;
  }

  Future<Map<String, dynamic>> applyCoupon(
    String coupon,
    double discount,
  ) async {
    final cart = await queryCart();
    cart['coupon']['coupon'] = coupon;
    cart['coupon']['discount'] = discount;
    _createCart(cart);
    return cart;
  }

  Future<Map<String, dynamic>> removeCoupon() async {
    final cart = await queryCart();
    cart['coupon']['coupon'] = '';
    cart['coupon']['discount'] = 0;
    _createCart(cart);
    return cart;
  }

  Future<bool> clearCart() {
    return _createCart(cartData);
  }

  List<Map<String, dynamic>> queryWishlist() {
    final jsonString = Prefs.getData<String>(key: 'wishlist_key') ?? '[]';
    return json.decode(jsonString).cast<Map<String, dynamic>>();
  }

  List<Map<String, dynamic>> removeProductFromWishlist(int productId) {
    final wishlist = queryWishlist();
    if (wishlist.any((element) => element['id'] == productId)) {
      wishlist.removeWhere((element) => element['id'] == productId);
      _createWishlist(wishlist);
      return wishlist;
    }

    throw RequestException('Could not find the product to remove');
  }

  Future<List<Map<String, dynamic>>> addProductToWishlist(
    int productId,
  ) async {
    final product = await queryProduct(productId);
    final wishlist = queryWishlist();
    if (!wishlist.any((element) => element['id'] == productId)) {
      wishlist.add(product!);
      _createWishlist(wishlist);
      return wishlist;
    }

    throw RequestException('Could not find the product to add');
  }
}
