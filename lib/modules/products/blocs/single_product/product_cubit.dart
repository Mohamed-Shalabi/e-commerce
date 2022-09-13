import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/cart/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.product,
    List<ProductModel> similarProducts = const [],
  })  : _similarProducts = similarProducts,
        super(ProductInitial());

  final ProductModel product;
  final List<ProductModel> _similarProducts;

  List<ProductModel> get similarProducts => [
        for (final similarProduct in _similarProducts)
          if (similarProduct.id != product.id) similarProduct
      ];

  void addProductToCart(ProductModel product) async {
    emit(AddOrRemoveProductLoading());

    final result = await CartRepository.addProductToCart(product);
    result.fold<void>(
      (l) => emit(AddOrRemoveProductFailed(message: l)),
      (r) => emit(AddOrRemoveProductSucceeded()),
    );
  }

  void removeProductFromCart(ProductModel product) async {
    emit(AddOrRemoveProductLoading());

    final result = await CartRepository.removeProductFromCart(product);
    result.fold<void>(
      (l) => emit(AddOrRemoveProductFailed(message: l)),
      (r) => emit(AddOrRemoveProductSucceeded()),
    );
  }
}
