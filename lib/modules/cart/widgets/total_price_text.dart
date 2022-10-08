import 'package:e_commerce/core/components/my_text.dart';
import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/cart/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalPriceText extends StatelessWidget {
  const TotalPriceText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<CartCubit>();
    final cart = CartModel.getInstance();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: MyText(
        '${AppStrings.totalAfterDiscount}: '
        '\$${(cart.price + 55).toStringAsFixed(2)}',
        style: context.textTheme.subtitle1,
      ),
    );
  }
}
