import 'package:e_commerce/core/components/my_error_widget.dart';
import 'package:e_commerce/core/components/show_snack_bar.dart';
import 'package:e_commerce/modules/products/blocs/products/products_cubit.dart';
import 'package:e_commerce/modules/products/widgets/products_responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (BuildContext context, ProductsState state) {
        if (state is ProductsFetchError) {
          context.showSnackBar(state.message);
        }
      },
      builder: (BuildContext context, ProductsState state) {
        final viewModel = context.read<ProductsCubit>();

        final appBar = AppBar(
          title: Text(viewModel.category.name),
        );

        if (state is ProductsLoading || state is ProductsInitial) {
          return Scaffold(
            appBar: appBar,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is ProductsFetchError) {
          return Scaffold(
            appBar: appBar,
            body: MyErrorWidget(message: state.message),
          );
        }

        return Scaffold(
          appBar: appBar,
          body: const ProductsResponsiveWidget(),
        );
      },
    );
  }
}
