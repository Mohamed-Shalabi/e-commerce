import 'dart:math';

import 'package:e_commerce/modules/products/blocs/single_product/product_view_model.dart';
import 'package:e_commerce/modules/products/widgets/product_list_card.dart';
import 'package:e_commerce/modules/products/widgets/toggle_is_product_in_wishlist_button.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:e_commerce/shared/styles/app_colors.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProductViewModel>();
    final product = viewModel.product;
    final similarProducts = viewModel.similarProducts;
    final categoryProducts = viewModel.categoryProducts;

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
                  const ToggleIsProductInWishlistButton(),
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
                    MyCard(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(4),
                      color: Colors.primaries[Random().nextInt(18)][
                          context.watch<AppThemesCubit>().isLight ? 100 : 900],
                      child: MyText(
                        component,
                        style: context.textTheme.bodyLarge,
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
                    return RepositoryProvider(
                      create: (_) => ProductViewModel(
                        product: product,
                        categoryProducts: categoryProducts,
                      ),
                      child: Builder(
                        builder: (context) {
                          return InkWell(
                            onTap: () {
                              context.navigate(
                                Routes.singleProductRouteName,
                                arguments: context.read<ProductViewModel>(),
                              );
                            },
                            child: const ProductHorizontalListCard(
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
