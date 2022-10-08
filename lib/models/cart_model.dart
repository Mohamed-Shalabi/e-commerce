import 'package:e_commerce/models/product_model.dart';

class CartModel extends Iterable<ProductListModel> {
  double _total;
  Map<ProductListModel, int> _products = {};

  static final CartModel _instance = CartModel._fromMap({});

  static void buildInstance(Map<String, dynamic> map) {
    final temp = CartModel._fromMap(map);
    _instance._copyFrom(temp);
  }

  factory CartModel.getInstance() => _instance;

  CartModel._fromMap(Map<String, dynamic> map) : _total = map['total'] ?? 0 {
    for (final productMapped in map['products'] ?? []) {
      _products[ProductListModel.fromMap(productMapped)] =
          productMapped['count'];
    }
  }

  static void clean() {
    _instance._products.clear();
    _instance._total = 0;
  }

  void addProduct(BaseProductModel product) {
    if (product is ProductListModel) {
      _addProduct(product);
    } else if (product is ProductModel) {
      _addProduct(product.asProductListModel);
    }
  }

  void removeProduct(BaseProductModel product) {
    if (product is ProductListModel) {
      _removeProduct(product);
    } else if (product is ProductModel) {
      _removeProduct(product.asProductListModel);
    }
  }

  void _removeProduct(ProductListModel product) {
    if (_products[product] == 1) {
      _products.remove(product);
    } else {
      _products[product] = _products[product]! - 1;
    }
  }

  void _addProduct(ProductListModel product) {
    if (_products[product] == null) {
      _products[product] = 1;
    } else {
      _products[product] = _products[product]! + 1;
    }
  }

  bool containsProduct(BaseProductModel product) {
    return _products.containsKey(product);
  }

  @override
  int get length => _products.entries.fold(
        0,
        (previousValue, element) => previousValue + element.value,
      );

  @override
  Iterator<ProductListModel> get iterator => _products.keys.iterator;

  int getProductCount(BaseProductModel product) {
    try {
      final key = _products.keys.firstWhere(
        (element) => element.id == product.id,
      );
      return _products[key] ?? 0;
    } on StateError {
      return 0;
    }
  }

  double get price {
    return _products.keys.fold(
      0,
      (previousValue, product) {
        return previousValue + product.price * _products[product]!;
      },
    );
  }

  double get total => _total;

  List<ProductListModel> get unique {
    return toSet().toList();
  }

  void _copyFrom(CartModel other) {
    _total = other.total;
    _products = other._products;
  }
}
