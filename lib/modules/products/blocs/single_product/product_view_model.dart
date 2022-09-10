import 'package:e_commerce/models/product_model.dart';

part 'product_state.dart';

class ProductViewModel {
  ProductViewModel({
    required this.product,
    required this.categoryProducts,
  });

  final ProductModel product;
  final List<ProductModel> categoryProducts;

  List<ProductModel> get similarProducts => [
        for (final categoryProduct in categoryProducts)
          if (categoryProduct.id != product.id) categoryProduct
      ];
}
