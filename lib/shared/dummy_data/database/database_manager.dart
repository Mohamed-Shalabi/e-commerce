import 'dart:convert';
import 'dart:io';

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
  static const String _categoriesTableName = 'categories';
  static const String _productsTableName = 'products';
  static const String _usersTableName = 'users';
  static const String _cartsTableName = 'carts';
  static const String _wishlistsTableName = 'wishlists';
  static const String _ordersTableName = 'orders';

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
    await _createCategoriesTable(database);
    await _createCartsTable(database);
    await _createWishlistsTable(database);
    await _createUsersTable(database);
    await _createOrdersTable(database);
  }

  Future<void> _fillTables(Database database) async {
    await _fillCategories(database);
    await _fillProducts(database);
  }

  Future<void> _createProductsTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_productsTableName ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
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
      'id INTEGER PRIMARY KEY, '
      'total DOUBLE NOT NULL, '
      'discount DOUBLE NOT NULL, '
      'coupon TEXT NOT NULL, '
      'products_ids TEXT NOT NULL'
      ')',
    );
  }

  Future<bool> addCart(int userId) async {
    final result = await _database!.insert(
      _cartsTableName,
      {
        'id': userId,
        'total': 0.0,
        'discount': 0.0,
        'coupon': '',
        'products_ids': '[]',
      },
    );

    return result > 0;
  }

  Future<void> _createWishlistsTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_wishlistsTableName ('
      'id INTEGER PRIMARY KEY, '
      'products_ids TEXT NOT NULL'
      ')',
    );
  }

  Future<void> _createOrdersTable(Database database) async {
    return database.execute(
      'CREATE TABLE $_ordersTableName ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'user_id INTEGER, '
      'total DOUBLE, '
      'products_ids TEXT NOT NULL'
      ')',
    );
  }

  Future<bool> addWishlist(int userId) async {
    final result = await _database!.insert(
      _wishlistsTableName,
      {
        'id': userId,
        'products_ids': '[]',
      },
    );

    return result > 0;
  }

  Future<int> _addOrderFromCart(Map<String, dynamic> cart) async {
    return await _database!.insert(
      _ordersTableName,
      {
        'user_id': cart['id'],
        'total': cart['total'],
        'products_ids': json.encode(
          cart['products'].map((e) => e['id']).toList(),
        ),
      },
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

    final userId = await _database!.insert(_usersTableName, user);
    final isCartCreated = await addCart(userId);
    final isWishlistCreated = await addWishlist(userId);

    if (isCartCreated && isWishlistCreated && userId > 0) {
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
      where: 'id=?',
      whereArgs: [userToken],
    );

    return result.first;
  }

  Future<bool> _updateCart(
    int userToken, [
    Map<String, dynamic> cart = cartData,
  ]) async {
    if (cart['total'] < 0) {
      throw _RequestException('Cart total cannot be negative');
    }

    final result = await _database!.update(
      _cartsTableName,
      cart,
      where: 'id=? ',
      whereArgs: [userToken],
    );

    return result > 0;
  }

  Future<bool> _createWishlist(
    int userToken, [
    List<Map<String, dynamic>>? wishlist,
  ]) async {
    wishlist ??= wishlistData;
    final productsIds = wishlist.map((e) => e['id']).toList();
    final result = await _database!.update(
      _wishlistsTableName,
      {'products_ids': json.encode(productsIds)},
      where: 'id=?',
      whereArgs: [userToken],
    );

    return result > 0;
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
    return _database!.query(_categoriesTableName);
  }

  Future<Map<String, Object?>?> queryCategory(int categoryId) {
    return _database!.query(
      _categoriesTableName,
      where: 'id=?',
      whereArgs: [categoryId],
    ).then((value) {
      return value.first;
    });
  }

  Future<List<Map<String, Object?>>?> queryCategoryProducts(
    int categoryId,
  ) async {
    final products = await _database!.query(
      _productsTableName,
      columns: ['id', 'category_id', 'quantity', 'price', 'title', 'images'],
      where: 'category_id=?',
      whereArgs: [categoryId],
    );

    final result = <Map<String, dynamic>>[];

    for (final product in products) {
      final growableProduct = {...product};
      _prepareProductForProductListModel(growableProduct);
      result.add(growableProduct);
    }

    return result;
  }

  Future<List<Map<String, Object?>>?> searchForProducts(
    String searchTerm,
  ) async {
    final products = await _database?.query(
      _productsTableName,
      distinct: true,
      where: 'title LIKE ?',
      whereArgs: ['%$searchTerm%'],
      columns: ['id', 'category_id', 'quantity', 'price', 'title', 'images'],
    );

    final result = <Map<String, dynamic>>[];

    for (final product in products!) {
      final growableProduct = {...product};
      _prepareProductForProductListModel(growableProduct);
      result.add(growableProduct);
    }

    return result;
  }

  Future<Map<String, Object?>?> queryProduct(
    int productId, {
    List<String>? columns,
  }) async {
    final result = await _database!.query(
      _productsTableName,
      where: 'id=?',
      whereArgs: [productId],
      columns: columns,
    );

    if (result.isEmpty) {
      throw _RequestException('Product not found');
    }

    return result.first;
  }

  Future<int> _updateProduct(Map<String, dynamic> product) {
    return _database!.update(
      _productsTableName,
      product,
      where: 'id=?',
      whereArgs: [product['id']],
    );
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
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

      return result[0];
    } catch (_) {
      throw _RequestException('Wrong email or password');
    }
  }

  Future<bool> logout() async {
    return await Prefs.saveOrRemoveData<int>(key: Prefs.userTokenKey);
  }

  // gets the cart with products as a map
  Future<Map<String, dynamic>> queryCart(int userToken) async {
    final result = await _database!.query(
      _cartsTableName,
      where: 'id=?',
      whereArgs: [userToken],
    );

    final cart = result[0];
    final cartProductsIds = json.decode(cart['products_ids'] as String);
    final products = <Map<String, dynamic>>[];
    for (final productId in cartProductsIds!) {
      final product =
          (await queryProduct(productId))?.cast<String, dynamic>() ?? {};
      if (product.isNotEmpty) {
        products.add(product);
      }
    }
    final growableCart = {...cart};
    growableCart['products'] = products;
    growableCart['coupon'] = {
      'coupon': growableCart['coupon'],
      'discount': growableCart['discount'],
    };
    growableCart.remove('discount');
    growableCart.remove('products_ids');
    return growableCart;
  }

  Future<Map<String, dynamic>> addProductToCart(
    int productId,
    int userToken,
  ) async {
    final product = await queryProduct(productId);
    final cart = await queryCart(userToken);

    final cartProductQuantity =
        cart['products'].where((element) => element['id'] == productId).length;
    if (cartProductQuantity >= (product!['quantity'] as int)) {
      throw _RequestException('Cannot add more');
    }

    cart['products_ids'] = cart['products'].map((e) => e['id']).toList();
    cart.remove('products');

    final productsIdsString = json.encode(
      cart['products_ids']..add(productId),
    );
    cart['products_ids'] = productsIdsString;
    cart['total'] += product['price'];

    cart['discount'] = cart['coupon']['discount'];
    cart['coupon'] = cart['coupon']['coupon'];

    _updateCart(userToken, cart);
    return cart;
  }

  Future<Map<String, dynamic>> removeProductFromCart(
    int productId,
    int userToken,
  ) async {
    final product = await queryProduct(productId);
    final cart = await queryCart(userToken);
    final index = cart['products'].indexWhere(
      (element) => element['id'] == productId,
    );

    if (index != -1) {
      cart['total'] -= product!['price'];
      cart['products'].removeAt(index);

      _prepareCartForDatabaseInsertion(cart);
      _updateCart(userToken, cart);
    } else {
      throw _RequestException('Could not remove from cart');
    }
    return cart;
  }

  Future<Map<String, dynamic>> applyCoupon(
    String coupon,
    double discount,
    int userToken,
  ) async {
    final cart = (await queryCart(userToken));
    final resultCart = {...cart};
    cart['coupon']['coupon'] = coupon;
    cart['coupon']['discount'] = discount;

    _prepareCartForDatabaseInsertion(cart);

    _updateCart(userToken, cart);
    return resultCart;
  }

  Future<Map<String, dynamic>> removeCoupon(int userToken) async {
    final cart = await queryCart(userToken);
    final resultCart = {...cart};

    cart['coupon']['coupon'] = '';
    cart['coupon']['discount'] = 0;

    _prepareCartForDatabaseInsertion(cart);
    _updateCart(userToken, cart);
    return resultCart;
  }

  Future<bool> placeOrderAndClearCart(int userToken) async {
    final cart = await queryCart(userToken);
    _addOrderFromCart(cart);
    final products = cart['products'];
    for (final product in products) {
      final Map<String, dynamic> growableProduct = {
        ...(await queryProduct(product['id']))!,
      };
      growableProduct['quantity'] -= 1;
      await _updateProduct(growableProduct);
    }

    return _updateCart(
      userToken,
      {
        'total': 0.0,
        'discount': 0.0,
        'coupon': '',
        'products_ids': '[]',
      },
    );
  }

  Future<List<Map<String, Object?>>> queryOrders(int userToken) {
    return _database!.query(
      _ordersTableName,
      where: 'user_id=?',
      whereArgs: [userToken],
    );
  }

  Future<List<Map<String, dynamic>>> queryWishlist(int userToken) async {
    final wishlists = await _database!.query(
      _wishlistsTableName,
      where: 'id=?',
      whereArgs: [userToken],
    );

    final wishlistProductsIds =
        json.decode(wishlists[0]['products_ids'] as String).cast<int>();

    final products = <Map<String, dynamic>>[];
    for (final productId in wishlistProductsIds) {
      final result = await queryProduct(
        productId,
        columns: ['id', 'category_id', 'quantity', 'price', 'title', 'images'],
      );
      products.add(result!);
    }

    final result = <Map<String, dynamic>>[];

    for (final product in products) {
      final growableProduct = {...product};
      _prepareProductForProductListModel(growableProduct);
      result.add(growableProduct);
    }

    return result;
  }

  Future<List<Map<String, dynamic>>> removeProductFromWishlist(
    int productId,
    int userToken,
  ) async {
    final wishlist = await queryWishlist(userToken);
    if (wishlist.any((element) => element['id'] == productId)) {
      wishlist.removeWhere((element) => element['id'] == productId);
      final isDone = await _createWishlist(userToken, wishlist);
      if (isDone) {
        return wishlist;
      }

      throw _RequestException('Could not remove product');
    }

    throw _RequestException('Could not find the product to remove');
  }

  Future<List<Map<String, dynamic>>> addProductToWishlist(
    int productId,
    int userToken,
  ) async {
    final product = await queryProduct(productId);
    final wishlist = await queryWishlist(userToken);
    if (!wishlist.any((element) => element['id'] == productId)) {
      final growableProduct = {...product!};
      _prepareProductForProductListModel(growableProduct);
      wishlist.add(growableProduct);
      final isDone = await _createWishlist(userToken, wishlist);
      if (isDone) {
        return wishlist;
      }

      throw _RequestException('Could not add product');
    }

    throw _RequestException('Could not find the product to add');
  }

  void _prepareCartForDatabaseInsertion(Map<String, dynamic> cart) {
    final productsIdsString = json.encode(
      cart['products'].map((e) => e['id']).toList(),
    );
    cart.remove('products');
    cart['products_ids'] = productsIdsString;

    cart['discount'] = cart['coupon']['discount'];
    cart['coupon'] = cart['coupon']['coupon'];
  }

  void _prepareProductForProductListModel(Map<String, dynamic> product) {
    product['main_image'] = json.decode(product['images'] as String).first;
    product.remove('images');
  }
}

class _RequestException implements Exception {
  final String message;

  _RequestException(this.message);

  @override
  String toString() {
    return message;
  }
}
