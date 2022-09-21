import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductListTile extends StatelessWidget {
  const CartProductListTile({
    Key? key,
    this.isInOrdersScreen = false,
  }) : super(key: key);

  final bool isInOrdersScreen;

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductListModel>();
    return SizedBox(
      width: double.infinity,
      height: 88,
      child: Row(
        children: [
          Image.asset(
            product.mainImage,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          const VerticalDivider(thickness: 3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        AppStrings.price,
                        style: context.textTheme.subtitle1,
                      ),
                      MyText(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: context.textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        AppStrings.quantity,
                        style: context.textTheme.subtitle1,
                      ),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          return MyText(
                            '${product.quantityInCart}',
                            style: context.textTheme.subtitle1,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        AppStrings.total,
                        style: context.textTheme.subtitle1,
                      ),
                      MyText(
                        '\$${product.totalPriceInCart.toStringAsFixed(2)}',
                        style: context.textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 3),
          if (!isInOrdersScreen)
            BlocConsumer<CartCubit, CartState>(
              listener: (_, CartState state) {
                if (state is CartAddOrRemoveProductFailed) {
                  context.showSnackBar(state.message);
                }
              },
              builder: (BuildContext context, CartState state) {
                if (context.read<CartCubit>().isProductLoading(product.id)) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return IconButton(
                  onPressed: () {
                    context.read<CartCubit>().removeProductFromCart(product);
                  },
                  icon: Icon(
                    Icons.remove_circle_outlined,
                    color: context.colorScheme.primary,
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}
