import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/cart/cart_repository.dart';
import 'package:e_commerce/modules/products/products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.productId,
    required this.categoryId,
  }) : super(ProductInitial()) {
    CartRepository.listenToPlaceOrderStream((event) {
      if (!isClosed) {
        getProductData();
      }
    });
  }

  final int productId;
  final int categoryId;

  late ProductModel product;
  late List<ProductModel> similarProducts;

  void getProductData() async {
    emit(GetProductLoading());

    final result = await ProductsRepository.getProductData(
      productId,
      categoryId,
    );
    result.fold<void>(
      (l) => emit(GetProductFailed(message: l)),
      (r) {
        product = r.product;
        similarProducts = r.similarProducts;
        emit(GetProductDone());
      },
    );
  }
}
