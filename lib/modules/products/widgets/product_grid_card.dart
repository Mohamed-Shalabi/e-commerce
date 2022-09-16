import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/products/widgets/product_list_card.dart';
import 'package:e_commerce/modules/products/widgets/product_price.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/utils/media_query_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGridCard extends StatelessWidget {
  const ProductGridCard({
    Key? key,
    this.isFromSingleProductScreen = false,
  }) : super(key: key);

  final bool isFromSingleProductScreen;

  @override
  Widget build(BuildContext context) {
    return MyCard(
      height: isFromSingleProductScreen ? 240 : context.screenWidth * 0.3,
      width: isFromSingleProductScreen ? 120 : null,
      margin: isFromSingleProductScreen
          ? const EdgeInsetsDirectional.only(end: 16)
          : EdgeInsets.zero,
      child: ProductGridCardContents(
        isFromSingleProductScreen: isFromSingleProductScreen,
      ),
    );
  }
}

class ProductGridCardContents extends StatelessWidget {
  const ProductGridCardContents({
    Key? key,
    required this.isFromSingleProductScreen,
  }) : super(key: key);

  final bool isFromSingleProductScreen;

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductModel>();

    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              width: isFromSingleProductScreen ? 120 : null,
              height: isFromSingleProductScreen ? 120 : null,
              child: Image.asset(
                product.images[0],
                width: isFromSingleProductScreen ? 120 : double.infinity,
                height: isFromSingleProductScreen
                    ? 120
                    : context.screenWidth * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: isFromSingleProductScreen ? 120 : null,
                  child: ProductListCardContents(
                    isFromSingleProductScreen: isFromSingleProductScreen,
                  ),
                ),
              ),
            ),
          ],
        ),
        const ProductPrice(),
      ],
    );
  }
}
