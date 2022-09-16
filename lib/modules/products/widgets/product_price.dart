import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final price = context.read<ProductModel>().price;
    return MyCard(
      color: context.colorScheme.secondary,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 2,
      ),
      child: MyText(
        '\$${price.toStringAsFixed(2)}',
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
