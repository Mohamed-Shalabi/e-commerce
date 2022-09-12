import 'package:e_commerce/models/product_model.dart';

part 'product_state.dart';

class ProductViewModel {
  ProductViewModel({
    required this.product,
    required List<ProductModel> similarProducts,
  }) : _similarProducts = similarProducts;

  final ProductModel product;
  final List<ProductModel> _similarProducts;

  List<ProductModel> get similarProducts => [
        for (final similarProduct in _similarProducts)
          if (similarProduct.id != product.id) similarProduct
      ];
}
