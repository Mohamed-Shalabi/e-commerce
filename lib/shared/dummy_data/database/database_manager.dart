import 'dart:convert';
import 'dart:io';

import 'package:e_commerce/shared/dummy_data/data/category.dart';
import 'package:e_commerce/shared/dummy_data/data/component.dart';
import 'package:e_commerce/shared/dummy_data/data/image.dart';
import 'package:e_commerce/shared/dummy_data/data/product.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:e_commerce/shared/local/prefs.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._();

  static final DatabaseManager _instance = DatabaseManager._();

  static const String _databaseName = 'app_database.db';
  static const String _categoriesTableName = 'categories';
  static const String _productsTableName = 'products';
  static const String _productsComponentsTableName = 'products_components';
  static const String _productsImagesTableName = 'images';
  static const String _usersTableName = 'users';
  static const String _cartsTableName = 'carts';
  static const String _cartsCouponsTableName = 'carts_coupons';
  static const String _wishlistsTableName = 'wishlists';
  static const String _ordersTableName = 'orders';
  static const String _ordersProductsTableName = 'orders_products';

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
        await _createTables(database);
        await _fillTables(database);
      },
    );
  }

  Future<void> _createTables(Database database) async {
    await _createProductsTable(database);
    await _createProductsComponentsTable(database);
    await _createProductsImagesTable(database);
    await _createCategoriesTable(database);
    await _createCartsTable(database);
    await _createCartsCouponsTable(database);
    await _createWishlistsTable(database);
    await _createUsersTable(database);
    await _createOrdersTable(database);
    await _createOrdersProductsTable(database);
  }

  Future<void> _fillTables(Database database) async {
    await _fillCategories(database);
    await _fillProducts(database);
    await _fillImages(database);
    await _fillProductsComponents(database);
  }

  Future<void> _createProductsTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_productsTableName ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'title TEXT NOT NULL, '
      'description TEXT NOT NULL, '
      'price DOUBLE NOT NULL, '
      'count INTEGER NOT NULL DEFAULT(1), '
      'category_id INTEGER NOT NULL'
      ')',
    );
  }

  Future<void> _createProductsComponentsTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_productsComponentsTableName ('
      'product_id INTEGER, '
      'name TEXT NOT NULL, '
      'PRIMARY KEY (product_id, name)'
      ')',
    );
  }

  Future<void> _createProductsImagesTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_productsImagesTableName ('
      'product_id INTEGER, '
      'image_path TEXT, '
      'FOREIGN KEY (product_id) REFERENCES $_productsTableName(id)'
      ')',
    );
  }

  Future<void> _createCategoriesTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_categoriesTableName ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'name TEXT NOT NULL'
      ')',
    );
  }

  Future<void> _createUsersTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_usersTableName ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'name TEXT NOT NULL, '
      'email TEXT UNIQUE NOT NULL, '
      'password TEXT NOT NULL, '
      'phone TEXT NOT NULL, '
      'country TEXT NOT NULL, '
      'city TEXT NOT NULL, '
      'address TEXT NOT NULL'
      ')',
    );
  }

  Future<void> _createCartsTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_cartsTableName ('
      'user_id INTEGER NOT NULL, '
      'product_id INTEGER NOT NULL, '
      'count INTEGER DEFAULT(1), '
      'PRIMARY KEY (user_id, product_id)'
      ')',
    );
  }

  Future<void> _createCartsCouponsTable(Database database) {
    return database.execute(
      'CREATE TABLE $_cartsCouponsTableName ('
      'user_id INTEGER NOT NULL PRIMARY KEY, '
      'discount DOUBLE NOT NULL, '
      'coupon TEXT NOT NULL'
      ')',
    );
  }

  Future<void> _createWishlistsTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_wishlistsTableName ('
      'user_id INTEGER, '
      'product_id INTEGER, '
      'PRIMARY KEY (user_id, product_id)'
      ')',
    );
  }

  Future<void> _createOrdersTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_ordersTableName ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'user_id INTEGER, '
      'total DOUBLE, '
      'date VARCHAR(10)'
      ')',
    );
  }

  Future<void> _createOrdersProductsTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_ordersProductsTableName ('
      'order_id INTEGER, '
      'product_id INTEGER, '
      'count INTEGER'
      ')',
    );
  }

  Future<String> createUser({
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

    final userId = await _database!.insert(_usersTableName, user);

    if (userId > 0) {
      return await login(email, password);
    }

    if (userId == 0) {
      throw _RequestException('Email already exists');
    }

    throw _RequestException('Could not save user');
  }

  Future<Map<String, dynamic>> queryUserProfile(int userToken) async {
    final result = await _database!.query(
      _usersTableName,
      where: 'id = ?',
      whereArgs: [userToken],
    );

    return result.first;
  }

  Future<void> _fillProducts(Database database) async {
    for (final product in allProductsData) {
      await database.insert(_productsTableName, product);
    }
  }

  Future<void> _fillCategories(Database database) async {
    for (final category in allCategoriesData) {
      await database.insert(_categoriesTableName, category);
    }
  }

  Future<void> _fillImages(Database database) async {
    for (final image in allImagesData) {
      await database.insert(_productsImagesTableName, image);
    }
  }

  Future<void> _fillProductsComponents(Database database) async {
    for (final component in allComponentsData) {
      await database.insert(_productsComponentsTableName, component);
    }
  }

  Future<String> queryCategories() async {
    final categories = await _database!.query(_categoriesTableName);
    return json.encode(categories);
  }

  Future<String> queryCategory(int categoryId) async {
    final category = _database!.query(
      _categoriesTableName,
      where: 'id = ?',
      whereArgs: [categoryId],
    );

    return json.encode(category);
  }

  Future<String> queryCategoryProducts(int categoryId) async {
    final products = await _database!.query(
      _productsTableName,
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );

    final result = <Map<String, dynamic>>[];

    for (final product in products) {
      final growableProduct = {...product};

      final images = await _database!.query(
        _productsImagesTableName,
        where: 'product_id = ?',
        whereArgs: [product['id']],
      );
      growableProduct['images'] = images.map((e) => e['image_path']).toList();

      _prepareProductForProductListModel(growableProduct);
      result.add(growableProduct);
    }

    return json.encode(result);
  }

  Future<String> searchForProducts(String searchTerm) async {
    final products = await _database!.query(
      _productsTableName,
      where: 'title LIKE %?%',
      whereArgs: [searchTerm],
    );

    final result = <Map<String, dynamic>>[];

    for (final product in products) {
      final growableProduct = {...product};

      final images = await _database!.query(
        _productsImagesTableName,
        where: 'product_id = ?',
        whereArgs: [product['id']],
      );
      growableProduct['images'] = json.encode(
        images.map((e) => e['image_path']).toList(),
      );

      _prepareProductForProductListModel(growableProduct);
      result.add(growableProduct);
    }

    return json.encode(result);
  }

  Future<String> queryProduct(int productId) async {
    final result = await _database!.query(
      _productsTableName,
      where: 'id = ?',
      whereArgs: [productId],
    );

    if (result.isEmpty) {
      throw _RequestException('Product not found');
    }

    final growableProduct = {...result.first};

    final imagesMapped = await _database!.query(
      _productsImagesTableName,
      where: 'product_id = ?',
      whereArgs: [productId],
    );

    final images = imagesMapped.map((e) => e['image_path']).toList();

    growableProduct['images'] = images;

    return json.encode(growableProduct);
  }

  Future<String> login(String email, String password) async {
    try {
      final result = await _database!.query(
        _usersTableName,
        where: 'email=? AND password=?',
        whereArgs: [email, password],
      );

      if (result.isEmpty) {
        throw _RequestException('Wrong email or password');
      }

      final id = result[0]['id'] as int;
      Prefs.saveOrRemoveData<int>(key: Prefs.userTokenKey, value: id);

      return json.encode(result[0]);
    } catch (_) {
      throw _RequestException('Wrong email or password');
    }
  }

  Future<bool> logout() async {
    return true;
  }

  Future<String> queryCart(int userToken) async {
    final cartData = await _database!.query(
      _cartsTableName,
      where: 'user_id = ?',
      whereArgs: [userToken],
    );

    final productsIds =
        cartData.map((e) => e['product_id']).toList().cast<int>();
    final productsCounts = cartData.map((e) => e['count']);
    final products = <Map<String, dynamic>>[];

    for (final productId in productsIds) {
      final productJson = await queryProduct(productId);
      final product = json.decode(productJson);
      final growableProduct = <String, dynamic>{...product};
      _prepareProductForProductListModel(growableProduct);
      growableProduct['count'] = productsCounts.elementAt(
        productsIds.indexOf(productId),
      );

      products.add(growableProduct);
    }

    final couponsData = await _database!.query(
      _cartsCouponsTableName,
      where: 'user_id = ?',
      whereArgs: [userToken],
    );

    final couponData = couponsData.isEmpty ? {} : couponsData[0];

    final cart = <String, dynamic>{
      'products': products,
      'coupon': couponData.isEmpty
          ? {}
          : {
              'coupon': couponData['coupon'],
              'discount': couponData['discount'],
            }
    };
    return json.encode(cart);
  }

  Future<String> addProductToCart(int productId, int userToken) async {
    final cartProducts = await _database!.query(
      _cartsTableName,
      where: 'user_id = ? AND product_id = ?',
      whereArgs: [userToken, productId],
    );

    if (cartProducts.isEmpty) {
      await _database!.insert(
        _cartsTableName,
        {
          'user_id': userToken,
          'product_id': productId,
          'count': 1,
        },
      );
    } else {
      await _database!.update(
        _cartsTableName,
        {'count': (cartProducts[0]['count'] as int) + 1},
        where: 'user_id = ? AND product_id = ?',
        whereArgs: [userToken, productId],
      );
    }

    return await queryCart(userToken);
  }

  Future<String> removeProductFromCart(
    int productId,
    int userToken,
  ) async {
    final cartProduct = await _database!.query(
      _cartsTableName,
      where: 'user_id = ? AND product_id = ?',
      whereArgs: [userToken, productId],
    );

    if (cartProduct.isEmpty) {
      throw _RequestException('Product is not in the cart');
    } else {
      final count = cartProduct[0]['count'] as int;
      if (count == 1) {
        await _database!.delete(
          _cartsTableName,
          where: 'user_id = ? AND product_id = ?',
          whereArgs: [userToken, productId],
        );
      } else {
        await _database!.update(
          _cartsTableName,
          {'count': (cartProduct[0]['count'] as int) - 1},
          where: 'user_id = ? AND product_id = ?',
          whereArgs: [userToken, productId],
        );
      }
    }

    return await queryCart(userToken);
  }

  Future<String> applyCoupon(
    String coupon,
    double discount,
    int userToken,
  ) async {
    await _database!.insert(
      _cartsCouponsTableName ,
      {
        'user_id': userToken,
        'coupon': coupon,
        'discount': discount,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return await queryCart(userToken);
  }

  Future<String> removeCoupon(int userToken) async {
    await _database!.execute(
      'DELETE FROM $_cartsCouponsTableName '
      'WHERE user_id = $userToken',
    );

    return await queryCart(userToken);
  }

  Future<String> placeOrderAndClearCart(int userToken) async {
    final cartResult = await queryCart(userToken);
    final cart = json.decode(cartResult);

    if (cart['products'].isEmpty) {
      throw _RequestException('The cart is empty');
    }

    final orderId = await _database!.insert(
      _ordersTableName,
      {
        'user_id': userToken,
        'date': DateUtils.today.formatted,
        'total': cart['products'].fold<double>(
              0.0,
              (double previousValue, element) {
                return previousValue + element['price'] * element['count'];
              },
            ) -
            (cart['coupon']['discount'] ?? 0.0),
      },
    );

    for (final cartProduct in cart['products']) {
      await _database!.insert(
        _ordersProductsTableName,
        {
          'order_id': orderId,
          'product_id': cartProduct['id'],
          'count': cartProduct['count'],
        },
      );

      final productString = await queryProduct(cartProduct['id']);
      final productJson = json.decode(productString);

      await _database!.update(
        _productsTableName,
        {
          'count': productJson['count'] - cartProduct['count'],
        },
        where: 'id = ?',
        whereArgs: [productJson['id']],
      );
    }

    await _database!.delete(
      _cartsTableName,
      where: 'user_id = ?',
      whereArgs: [userToken],
    );

    return json.encode({'message': 'done'});
  }

  Future<String> queryOrders(int userToken) async {
    final orders = await _database!.query(
      _ordersTableName,
      where: 'user_id = ?',
      whereArgs: [userToken],
    );

    final growableOrders = <Map<String, dynamic>>[];

    for (final order in orders) {
      final growableOrder = {...order};
      final ordersResult = await _database!.query(
        _ordersProductsTableName,
        where: 'order_id = ?',
        whereArgs: [growableOrder['id']],
      );

      final orderProductsIds =
          ordersResult.map((e) => e['product_id'] as int).toList();
      final orderProductsCounts = ordersResult.map((e) => e['count']).toList();

      final orderProducts = <Map<String, dynamic>>[];
      for (var i = 0; i < ordersResult.length; i++) {
        final productId = orderProductsIds[i];
        final productCount = orderProductsCounts[i];

        final productString = await queryProduct(productId);
        final Map<String, dynamic> productMapped = json.decode(productString);

        final growableProduct = {...productMapped};
        growableProduct['count'] = productCount;

        _prepareProductForProductListModel(growableProduct);
        orderProducts.add(growableProduct);
      }

      growableOrder['products'] = orderProducts;
      growableOrders.add(growableOrder);
    }

    return json.encode(growableOrders);
  }

  Future<String> queryWishlist(int userToken) async {
    final wishlist = await _database!.query(
      _wishlistsTableName,
      where: 'user_id = ?',
      whereArgs: [userToken],
    );

    final products = <Map<String, dynamic>>[];
    final productsIds = wishlist.map((e) => e['product_id']).cast<int>();

    for (final productId in productsIds) {
      final product = await queryProduct(productId);
      final jsonProduct = json.decode(product);
      _prepareProductForProductListModel(jsonProduct);
      products.add(jsonProduct);
    }

    return json.encode(products);
  }

  Future<String> removeProductFromWishlist(
    int productId,
    int userToken,
  ) async {
    final result = await _database!.delete(
      _wishlistsTableName,
      where: 'user_id = ? AND product_id = ?',
      whereArgs: [userToken, productId],
    );

    if (result == 0) {
      throw _RequestException('Product is not in the wishlist');
    }

    return await queryWishlist(userToken);
  }

  Future<String> addProductToWishlist(
    int productId,
    int userToken,
  ) async {
    final result = await _database!.insert(
      _wishlistsTableName,
      {
        'user_id': userToken,
        'product_id': productId,
      },
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );

    if (result == 0) {
      throw _RequestException('Product is already in the wishlist');
    }

    return await queryWishlist(userToken);
  }

  void _prepareProductForProductListModel(Map<String, dynamic> product) {
    product['main_image'] = product['images'].first;
    product.remove('images');
  }
}

class _RequestException implements Exception {
  final String _message;

  _RequestException(this._message);

  @override
  String toString() {
    return _message;
  }
}
