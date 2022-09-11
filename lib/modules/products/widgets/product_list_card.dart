import 'package:e_commerce/modules/products/blocs/single_product/product_view_model.dart';
import 'package:e_commerce/modules/products/widgets/toggle_is_product_in_wishlist_button.dart';
import 'package:e_commerce/responsive/responsive_widget.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/media_query_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductVerticalListCard extends StatelessWidget {
  const ProductVerticalListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProductViewModel>();
    final product = viewModel.product;
    return MyCard(
      height: 80,
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Row(
            children: [
              Hero(
                tag: 'product_image:${product.id}',
                child: Image.asset(
                  product.images[0],
                  width: context.screenWidth / 3 - 24,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ProductListCardDataWidget(),
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

class ProductHorizontalListCard extends StatelessWidget {
  const ProductHorizontalListCard({
    Key? key,
    this.isFromSingleProductScreen = false,
  }) : super(key: key);

  final bool isFromSingleProductScreen;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobileWidget: MyCard(
        width: context.screenWidth * 0.5,
        margin: const EdgeInsetsDirectional.only(end: 16),
        child: ProductHorizontalListCardContents(
          isFromSingleProductScreen: isFromSingleProductScreen,
        ),
      ),
      tabletWidget: MyCard(
        width: context.screenWidth * 0.2,
        margin: const EdgeInsetsDirectional.only(end: 16),
        child: ProductHorizontalListCardContents(
          isFromSingleProductScreen: isFromSingleProductScreen,
        ),
      ),
    );
  }
}

class ProductHorizontalListCardContents extends StatelessWidget {
  const ProductHorizontalListCardContents({
    Key? key,
    required this.isFromSingleProductScreen,
  }) : super(key: key);

  final bool isFromSingleProductScreen;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProductViewModel>();
    final product = viewModel.product;

    return Stack(
      children: [
        Column(
          children: [
            Hero(
              tag: 'product_image:${product.id}',
              child: Image.asset(
                product.images[0],
                width: double.infinity,
                height: isFromSingleProductScreen
                    ? 120
                    : context.screenHeight * 0.5,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductListCardDataWidget(
                  isFromSingleProductScreen: isFromSingleProductScreen,
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

class ProductPrice extends StatelessWidget {
  const ProductPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final price = context.read<ProductViewModel>().product.price;
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

class ProductListCardDataWidget extends StatelessWidget {
  const ProductListCardDataWidget({
    Key? key,
    this.isFromSingleProductScreen = false,
  }) : super(key: key);

  final bool isFromSingleProductScreen;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProductViewModel>();
    final product = viewModel.product;
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
                  child: ToggleIsProductInWishlistButton(),
                )
            ],
          ),
        ),
        if (!isFromSingleProductScreen)
          IconButton(
            onPressed: () {},
            icon: const ToggleIsProductInWishlistButton(),
          ),
      ],
    );
  }
}
