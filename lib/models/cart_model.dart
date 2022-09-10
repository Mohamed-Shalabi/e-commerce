import 'package:e_commerce/models/product_model.dart';

class CartModel extends Iterable<ProductModel> {
  final double total;
  final CouponModel coupon;
  final List<ProductModel> _products = [];

  static late final CartModel? _instance;

  static void init(Map<String, dynamic> map) {
    _instance = CartModel._fromMap(map);
  }

  factory CartModel.getInstance() => _instance!;

  CartModel._fromMap(Map<String, dynamic> map)
      : total = map['total'] ?? 0,
        coupon = CouponModel._fromMap(map['coupon'] ?? {}) {
    _products
      ..clear()
      ..addAll(ProductModel.parseList(map['products']));
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
    _instance.discount = map['discount'] ?? _instance.discount;
    return _instance;
  }

  CouponModel._initiate()
      : coupon = '',
        discount = 0.0;
}
