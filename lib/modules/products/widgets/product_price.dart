import 'package:e_commerce/core/components/my_card.dart';
import 'package:e_commerce/core/components/my_text.dart';
import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:e_commerce/modules/products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final price = context.read<ProductListModel>().price;
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
