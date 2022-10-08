import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
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
