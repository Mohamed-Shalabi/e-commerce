import 'package:e_commerce/core/components/my_card.dart';
import 'package:e_commerce/core/components/my_text.dart';
import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:e_commerce/core/utils/media_query_utils.dart';
import 'package:e_commerce/modules/products/models/product_model.dart';
import 'package:e_commerce/modules/products/widgets/product_price.dart';
import 'package:e_commerce/modules/products/widgets/toggle_is_product_in_wishlist_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListCard extends StatelessWidget {
  const ProductListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductListModel>();
    return MyCard(
      height: 80,
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Row(
            children: [
              Image.asset(
                product.mainImage,
                width: context.screenWidth / 3 - 24,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ProductListCardContents(),
                ),
              ),
            ],
          ),
          const ProductPrice(),
        ],
      ),
    );
  }
}

class ProductListCardContents extends StatelessWidget {
  const ProductListCardContents({
    Key? key,
    this.isFromSingleProductScreen = false,
  }) : super(key: key);

  final bool isFromSingleProductScreen;

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductListModel>();
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                product.title,
                style: context.textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              MyText(
                product.quantityAsString,
                style: context.textTheme.labelSmall?.copyWith(
                  color:
                      product.quantity < 4 ? context.colorScheme.error : null,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (isFromSingleProductScreen)
                const Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: ToggleIsProductInWishlistButton<ProductListModel>(),
                )
            ],
          ),
        ),
        if (!isFromSingleProductScreen)
          IconButton(
            onPressed: () {},
            icon: const ToggleIsProductInWishlistButton<ProductListModel>(),
          ),
      ],
    );
  }
}
