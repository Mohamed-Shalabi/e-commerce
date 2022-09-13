import 'package:e_commerce/modules/products/blocs/products/base_products_cubit.dart';
import 'package:e_commerce/modules/products/blocs/single_product/product_cubit.dart';
import 'package:e_commerce/modules/products/widgets/product_list_card.dart';
import 'package:e_commerce/responsive/responsive_widget.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsResponsiveWidget<T extends BaseProductsCubit>
    extends StatelessWidget {
  const ProductsResponsiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.watch<T>().products;

    return ResponsiveWidget(
      mobileWidget: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return BlocProvider(
            key: ObjectKey(product),
            create: (_) => ProductCubit(
              product: product,
              similarProducts: products,
            ),
            child: Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  final viewModel = context.read<ProductCubit>();
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
      tabletWidget: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return BlocProvider(
            create: (_) => ProductCubit(
              product: product,
              similarProducts: products,
            ),
            child: Builder(
              builder: (context) {
                return InkWell(
                  onTap: () {
                    final viewModel = context.read<ProductCubit>();
                    context.navigate(
                      Routes.singleProductRouteName,
                      arguments: viewModel,
                    );
                  },
                  child: const ProductGridCard(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
