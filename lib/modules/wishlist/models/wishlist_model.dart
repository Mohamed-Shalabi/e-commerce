import 'package:e_commerce/modules/products/models/product_model.dart';

class WishlistModel extends Iterable<ProductListModel> {
  final List<ProductListModel> _products;

  WishlistModel._() : _products = [];

  static final _instance = WishlistModel._();

  factory WishlistModel.getInstance() => _instance;

  @override
  Iterator<ProductListModel> get iterator => _products.iterator;

  void add(ProductListModel product) {
    _products.add(product);
  }

  void remove(ProductModel product) {
    _products.remove(product);
  }

  void clear() {
    _products.clear();
  }

  void addAll(Iterable<ProductListModel> products) {
    _products.addAll(products);
  }
}
