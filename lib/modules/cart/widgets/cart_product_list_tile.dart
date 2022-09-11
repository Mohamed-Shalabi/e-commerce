import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductListTile extends StatelessWidget {
  const CartProductListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductModel>();
    return SizedBox(
      width: double.infinity,
      height: 120,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  child: MyText(
                    AppStrings.price,
                    style: context.textTheme.subtitle1,
                  ),
                ),
                FittedBox(
                  child: MyText(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: context.textTheme.subtitle1,
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 3),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  child: MyText(
                    AppStrings.quantity,
                    style: context.textTheme.subtitle1,
                  ),
                ),
                FittedBox(
                  child: MyText(
                    '${product.quantityInCart}',
                    style: context.textTheme.subtitle1,
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 3),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  child: MyText(
                    AppStrings.total,
                    style: context.textTheme.subtitle1,
                  ),
                ),
                FittedBox(
                  child: MyText(
                    '\$${product.totalPriceInCart.toStringAsFixed(2)}',
                    style: context.textTheme.subtitle1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
