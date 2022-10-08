import 'package:e_commerce/models/product_model.dart';

class CartModel extends Iterable<ProductListModel> {
  double _total;
  CouponModel _coupon;
  Map<ProductListModel, int> _products = {};

  static final CartModel _instance = CartModel._fromMap({});

  static void buildInstance(Map<String, dynamic> map) {
    final temp = CartModel._fromMap(map);
    _instance._copyFrom(temp);
  }

  factory CartModel.getInstance() => _instance;

  CartModel._fromMap(Map<String, dynamic> map)
      : _total = map['total'] ?? 0,
        _coupon = CouponModel._fromMap(map['coupon'] ?? {}) {
    for (final productMapped in map['products'] ?? []) {
      _products[ProductListModel.fromMap(productMapped)] =
          productMapped['count'];
    }
  }

  static void clean() {
    _instance._products.clear();
    _instance.coupon.coupon = '';
    _instance.coupon.discount = 0;
    _instance._total = 0;
  }

  double get totalAfterDiscount => total - coupon.discount;

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

  double get priceBeforeDiscount {
    return _products.keys.fold(
      0,
      (previousValue, product) => previousValue + product.price,
    );
  }

  double get priceAfterDiscount {
    final result = priceBeforeDiscount - coupon.discount;
    if (result < 0) {
      return 0;
    } else {
      return result;
    }
  }

  double get total => _total;

  CouponModel get coupon => _coupon;

  List<ProductListModel> get unique {
    return toSet().toList();
  }

  void _copyFrom(CartModel other) {
    _coupon = other.coupon;
    _total = other.total;
    _products = other._products;
  }
}

class CouponModel {
  String coupon;
  double discount;

  static final _instance = CouponModel._initiate();

  factory CouponModel.getInstance({String? coupon, double? discount}) {
    _instance.coupon = coupon ?? _instance.coupon;
    _instance.discount = discount ?? _instance.discount;
    return _instance;
  }

  factory CouponModel._fromMap(Map<String, dynamic> map) {
    _instance.coupon = map['coupon'] ?? '';
    _instance.discount = map['discount']?.toDouble() ?? 0;
    return _instance;
  }

  CouponModel._initiate()
      : coupon = '',
        discount = 0.0;
}
