import 'package:e_commerce/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseProductsCubit<T> extends Cubit<T> {
  BaseProductsCubit(super.initialState);

  List<ProductModel> products = [];
}
