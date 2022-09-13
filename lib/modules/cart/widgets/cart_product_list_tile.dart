import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/products/blocs/single_product/product_cubit.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductListTile extends StatelessWidget {
  const CartProductListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductCubit>().product;
    return SizedBox(
      width: double.infinity,
      height: 88,
      child: Row(
        children: [
          Image.asset(
            product.images.first,
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
          BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {
              if (state is AddOrRemoveProductSucceeded) {
                context.read<CartCubit>().removeProductFromCart(product);
              }
            },
            builder: (context, state) {
              context.watch<CartCubit>();
              return state is AddOrRemoveProductLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : IconButton(
                      onPressed: () {
                        context
                            .read<ProductCubit>()
                            .removeProductFromCart(product);
                      },
                      icon: const Icon(Icons.remove_circle_outlined),
                    );
            },
          ),
        ],
      ),
    );
  }
}
