import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/products/blocs/single_product/product_cubit.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleProductFloatingActionButtons extends StatelessWidget {
  const SingleProductFloatingActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductCubit>().product;
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (_, ProductState state) {
        if (state is AddOrRemoveProductFailed) {
          context.showSnackBar(state.message);
        }
      },
      builder: (_, ProductState state) {
        context.watch<CartCubit>();
        if (state is AddOrRemoveProductLoading) {
          return MyCard(
            width: 56,
            height: 56,
            borderRadius: 28,
            padding: const EdgeInsets.all(16),
            color: context.colorScheme.secondary,
            child: const CircularProgressIndicator(),
          );
        }

        final cart = CartModel.getInstance();

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (product.quantity > 0 &&
                product.quantityInCart < product.quantity)
              FloatingActionButton(
                heroTag: 'add_product',
                onPressed: () {
                  context.read<ProductCubit>().addProductToCart(product);
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
                      heroTag: 'remove_product',
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
                              '${cart.length}',
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
                    heroTag: 'remove',
                    onPressed: () {
                      context.read<ProductCubit>().removeProductFromCart(product);
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
