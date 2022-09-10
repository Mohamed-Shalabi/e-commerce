import 'package:e_commerce/modules/products/blocs/products/products_cubit.dart';
import 'package:e_commerce/modules/products/blocs/single_product/product_view_model.dart';
import 'package:e_commerce/modules/products/widgets/product_list_card.dart';
import 'package:e_commerce/modules/wishlist/blocs/wishlist_cubit.dart';
import 'package:e_commerce/responsive/responsive_Builder.dart';
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
          final products = state.products;
          return Scaffold(
            appBar: appBar,
            body: BlocBuilder<WishlistCubit, WishlistState>(
              builder: (context, state) {
                return ResponsiveWidget(
                  mobileWidget: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return RepositoryProvider(
                        create: (_) => ProductViewModel(
                          product: product,
                          categoryProducts: products,
                        ),
                        child: Builder(builder: (context) {
                          return InkWell(
                            onTap: () {
                              final viewModel =
                                  context.read<ProductViewModel>();
                              context.navigate(
                                Routes.singleProductRouteName,
                                arguments: viewModel,
                              );
                            },
                            child: const ProductVerticalListCard(),
                          );
                        }),
                      );
                    },
                  ),
                  tabletWidget: ListView.builder(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      16,
                      16,
                      0,
                      16,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return RepositoryProvider(
                        create: (_) => ProductViewModel(
                          product: product,
                          categoryProducts: products,
                        ),
                        child: Builder(
                          builder: (context) {
                            return InkWell(
                              onTap: () {
                                final viewModel =
                                    context.read<ProductViewModel>();
                                context.navigate(
                                  Routes.singleProductRouteName,
                                  arguments: viewModel,
                                );
                              },
                              child: const ProductHorizontalListCard(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }

        return const MyErrorWidget(message: AppStrings.unknownError);
      },
    );
  }
}
