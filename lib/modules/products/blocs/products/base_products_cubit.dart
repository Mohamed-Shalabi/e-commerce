import 'package:e_commerce/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseProductsCubit<T> extends Cubit<T> {
  BaseProductsCubit(super.initialState);

  Iterable<ProductListModel> get products;

  set products(Iterable<ProductListModel> value);
}
