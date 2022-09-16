import 'package:e_commerce/models/product_model.dart';

class WishlistModel extends Iterable<ProductModel> {
  final List<ProductModel> _products;

  WishlistModel._() : _products = [];

  static final _instance = WishlistModel._();

  factory WishlistModel.getInstance() => _instance;

  @override
  Iterator<ProductModel> get iterator => _products.iterator;

  void add(ProductModel product) {
    _products.add(product);
  }

  void remove(ProductModel product) {
    _products.remove(product);
  }

  void clear() {
    _products.clear();
  }

  void addAll(Iterable<ProductModel> products) {
    _products.addAll(products);
  }
}
