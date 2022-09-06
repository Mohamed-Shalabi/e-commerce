import 'dart:convert';

import 'package:e_commerce/shared/dummy_data/data/cart.dart';
import 'package:e_commerce/shared/dummy_data/data/category.dart';
import 'package:e_commerce/shared/dummy_data/data/product.dart';
import 'package:e_commerce/shared/local/prefs.dart';
import 'package:path/path.dart' as p;
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
    final path = await getDatabasesPath();
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

  Future<Map<String, dynamic>?> createUser(Map<String, dynamic> user) async {
    await Prefs.saveOrRemoveData<String>(
      key: 'user_key',
      value: jsonEncode(user),
    );

    return user;
  }

  Future<bool> removeUser() async {
    return await Prefs.saveOrRemoveData<String>(key: 'user_key');
  }

  Future<bool> _createCart([Map<String, dynamic>? cart]) {
    cart ??= cartData;
    if (cart['total_after_discount'] < 0) {
      cart['total_after_discount'] = 0;
    }
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

  Future<List<Map<String, Object?>>?>? queryCategories() {
    return _database?.query(_categoriesTableName);
  }

  Future<Map<String, Object?>?>? queryCategory(int categoryId) {
    return _database?.query(
      _categoriesTableName,
      where: 'id = ?',
      whereArgs: [categoryId],
    ).then((value) {
      return value.first;
    });
  }

  Future<List<Map<String, Object?>>?>? queryCategoryProducts(
    int categoryId,
  ) async {
    return await _database?.query(
      _productsTableName,
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
  }

  Future<Map<String, Object?>?>? queryProduct(int productId) async {
    return await _database?.query(
      _productsTableName,
      where: 'id = ?',
      whereArgs: [productId],
    ).then((value) {
      return value.first;
    });
  }

  Map<String, dynamic> queryUser() {
    final jsonString = Prefs.getData<String>(key: 'user_key')!;
    return json.decode(jsonString);
  }

  Map<String, dynamic> queryCart() {
    final jsonString = Prefs.getData<String>(key: 'cart_key')!;
    return json.decode(jsonString);
  }

  Future<Map<String, dynamic>> addProductToCart(int productId) async {
    final product = await queryProduct(productId);
    final cart = queryCart();
    cart['products'].add(product!['id']);
    cart['total'] += product['price'];
    cart['total_after_discount'] += product['price'];
    _createCart(cart);
    return cart;
  }

  Future<Map<String, dynamic>> removeProductFromCart(int productId) async {
    final product = await queryProduct(productId);
    final cart = queryCart();
    final isRemoved = cart['products'].remove(product!['id']);
    if (isRemoved) {
      cart['total'] -= product['price'];
      cart['total_after_discount'] -= product['price'];
      _createCart(cart);
    } else {
      throw Exception();
    }
    return cart;
  }

  Map<String, dynamic> applyCoupon(String coupon, double discount) {
    final cart = queryCart();
    cart['coupon']['coupon'] = coupon;
    cart['coupon']['discount'] = discount;
    cart['total_after_discount'] = cart['total'] - discount;
    _createCart(cart);
    return cart;
  }

  List<Map<String, dynamic>> queryWishlist() {
    final jsonString = Prefs.getData<String>(key: 'wishlist_key') ?? '[]';
    return json.decode(jsonString).cast<Map<String, dynamic>>();
  }

  List<Map<String, dynamic>> removeProductFromWishlist(int productId) {
    final wishlist = queryWishlist();
    wishlist.removeWhere((element) => element['id'] == productId);
    _createWishlist(wishlist);
    return wishlist;
  }

  Future<List<Map<String, dynamic>>> addProductToWishlist(
    int productId,
  ) async {
    final product = await queryProduct(productId);
    final wishlist = queryWishlist();
    if (!wishlist.any((element) => element['id'] == productId)) {
      wishlist.add(product!);
    }
    _createWishlist(wishlist);
    return wishlist;
  }
}
