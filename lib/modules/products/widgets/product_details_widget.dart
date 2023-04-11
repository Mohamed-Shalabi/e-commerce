import 'dart:math';

import 'package:e_commerce/core/components/my_card.dart';
import 'package:e_commerce/core/components/my_text.dart';
import 'package:e_commerce/core/functions/functions.dart';
import 'package:e_commerce/core/styles/app_colors.dart';
import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/products/blocs/single_product/product_cubit.dart';
import 'package:e_commerce/modules/products/models/product_model.dart';
import 'package:e_commerce/modules/products/widgets/product_grid_card.dart';
import 'package:e_commerce/modules/products/widgets/toggle_is_product_in_wishlist_button.dart';
import 'package:e_commerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductCubit>();
    final product = viewModel.product;
    final similarProducts = viewModel.similarProducts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyText(
                      product.title,
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  RepositoryProvider.value(
                    value: product,
                    child:
                        const ToggleIsProductInWishlistButton<ProductModel>(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MyText(
                product.description * 10,
                style: context.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Divider(thickness: 5),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                '${AppStrings.price}: \$${product.price}',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              MyText(
                product.quantityAsString,
                style: context.textTheme.titleMedium?.copyWith(
                  color: product.quantity < 4
                      ? context.colorScheme.error
                      : AppColors.muchQuantityColor,
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 5),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                '${AppStrings.productComponents}:',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                children: [
                  for (final component in product.components)
                    StateConsumer<AppThemesState>(
                      initialState:
                          stateHolder.lastStateOfContextType(AppThemesState)
                              as AppThemesState,
                      builder: (context, state) => MyCard(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(4),
                        color: Colors.primaries[Random().nextInt(18)]
                            [state.isLight ? 100 : 900],
                        child: MyText(
                          component,
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const Divider(thickness: 5),
        if (similarProducts.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8,
                ),
                child: MyText(
                  '${AppStrings.similarProducts}:',
                  style: context.textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: 260,
                child: ListView.builder(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 0, 32),
                  scrollDirection: Axis.horizontal,
                  itemCount: similarProducts.length,
                  itemBuilder: (context, index) {
                    final product = similarProducts[index];
                    return RepositoryProvider.value(
                      value: product,
                      child: Builder(
                        builder: (context) {
                          return InkWell(
                            onTap: () {
                              context.navigate(
                                Routes.singleProductRouteName,
                                arguments: context.read<ProductModel>(),
                              );
                            },
                            child: const ProductGridCard(
                              isFromSingleProductScreen: true,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }
}
