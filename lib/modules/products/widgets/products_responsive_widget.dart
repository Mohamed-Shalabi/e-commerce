import 'package:e_commerce/core/functions/functions.dart';
import 'package:e_commerce/core/responsive/responsive_widget.dart';
import 'package:e_commerce/modules/products/blocs/products/products_cubit.dart';
import 'package:e_commerce/modules/products/widgets/product_grid_card.dart';
import 'package:e_commerce/modules/products/widgets/product_list_card.dart';
import 'package:e_commerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsResponsiveWidget extends StatelessWidget {
  const ProductsResponsiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductsCubit>().products;

    return ResponsiveWidget(
      mobileWidget: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products.elementAt(index);
          return RepositoryProvider.value(
            key: ObjectKey(product),
            value: product,
            child: Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  context.navigate(
                    Routes.singleProductRouteName,
                    arguments: product,
                  );
                },
                child: const ProductListCard(),
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
          final product = products.elementAt(index);
          return RepositoryProvider.value(
            key: ObjectKey(product),
            value: product,
            child: Builder(
              builder: (context) {
                return InkWell(
                  onTap: () {
                    context.navigate(
                      Routes.singleProductRouteName,
                      arguments: product,
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
