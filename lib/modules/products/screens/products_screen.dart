import 'package:e_commerce/modules/products/blocs/products/products_cubit.dart';
import 'package:e_commerce/modules/products/blocs/single_product/product_view_model.dart';
import 'package:e_commerce/modules/products/widgets/product_list_card.dart';
import 'package:e_commerce/modules/products/widgets/products_responsive_widget.dart';
import 'package:e_commerce/modules/wishlist/blocs/wishlist_cubit.dart';
import 'package:e_commerce/responsive/responsive_widget.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/components/my_error_widget.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:e_commerce/shared/utils/media_query_utils.dart';
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
            body: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: context.screenWidth * 0.5,
                    child: MyErrorWidget(message: state.message),
                  )
                ],
              ),
            ),
          );
        }

        if (state is ProductsFetched) {
          return Scaffold(
            appBar: appBar,
            body: BlocBuilder<WishlistCubit, WishlistState>(
              builder: (context, state) {
                return const ProductsResponsiveWidget<ProductsCubit>();
              },
            ),
          );
        }

        return const MyErrorWidget(message: AppStrings.unknownError);
      },
    );
  }
}
