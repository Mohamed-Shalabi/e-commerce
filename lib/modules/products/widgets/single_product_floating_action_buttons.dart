import 'package:e_commerce/core/components/my_card.dart';
import 'package:e_commerce/core/components/my_text.dart';
import 'package:e_commerce/core/components/show_snack_bar.dart';
import 'package:e_commerce/core/functions/functions.dart';
import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/cart/models/cart_model.dart';
import 'package:e_commerce/modules/products/blocs/single_product/product_cubit.dart';
import 'package:e_commerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleProductFloatingActionButtons extends StatelessWidget {
  const SingleProductFloatingActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductCubit>().product;
    return BlocConsumer<CartCubit, CartState>(
      listener: (_, CartState state) {
        if (state is CartAddOrRemoveProductFailed) {
          context.showSnackBar(state.message);
        }
      },
      builder: (_, CartState state) {
        if (context.read<CartCubit>().isProductLoading(product.id)) {
          return MyCard(
            width: 56,
            height: 56,
            borderRadius: 28,
            padding: const EdgeInsets.all(16),
            color: context.colorScheme.secondary,
            child: const CircularProgressIndicator(),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (product.quantity > 0 &&
                product.quantityInCart < product.quantity)
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  context.read<CartCubit>().addProductToCart(product);
                },
                child: const Icon(Icons.add),
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        context.navigate(Routes.cartRouteName);
                      },
                      child: const Icon(Icons.shopping_bag_outlined),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: context.colorScheme.error,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Center(
                            child: MyText(
                              '${CartModel.getInstance().length}',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colorScheme.onError,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Center(
                            child: MyText(
                              '${product.quantityInCart}',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colorScheme.onError,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                if (product.quantityInCart > 0) ...[
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      context.read<CartCubit>().removeProductFromCart(product);
                    },
                    child: const Icon(Icons.remove),
                  ),
                ]
              ],
            ),
          ],
        );
      },
    );
  }
}
