import 'package:e_commerce/models/product_model.dart';

class CartModel extends Iterable<ProductModel> {
  double _total;
  CouponModel _coupon;
  List<ProductModel> _products = [];

  static final CartModel _instance = CartModel._fromMap({});

  static void buildInstance(Map<String, dynamic> map) {
    final temp = CartModel._fromMap(map);
    _instance.copyFrom(temp);
  }

  factory CartModel.getInstance() => _instance;

  CartModel._fromMap(Map<String, dynamic> map)
      : _total = map['total'] ?? 0,
        _coupon = CouponModel._fromMap(map['coupon'] ?? {}) {
    _products
      ..clear()
      ..addAll(ProductModel.parseList(map['products'] ?? []));
  }

  static void clear() {
    _instance._products.clear();
    _instance.coupon.coupon = '';
    _instance.coupon.discount = 0;
    _instance._total = 0;
  }

  double get totalAfterDiscount => total - coupon.discount;

  void addProduct(ProductModel product) {
    _products.add(product);
  }

  void removeProduct(ProductModel product) {
    final index = _products.indexWhere((element) => element.id == product.id);
    _products.removeAt(index);
  }

  bool containsProduct(ProductModel product) {
    return _products.contains(product);
  }

  @override
  int get length => _products.length;

  @override
  Iterator<ProductModel> get iterator => _products.iterator;

  int numberOfProduct(ProductModel product) {
    return where((element) => element.id == product.id).length;
  }

  double get priceBeforeDiscount {
    return _products.fold(
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

  List<ProductModel> get unique {
    return toSet().toList();
  }

  void copyFrom(CartModel other) {
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
    _instance.coupon = map['coupon'] ?? _instance.coupon;
    _instance.discount = map['discount']?.toDouble() ?? _instance.discount;
    return _instance;
  }

  CouponModel._initiate()
      : coupon = '',
        discount = 0.0;
}
