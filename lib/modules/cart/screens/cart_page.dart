import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/cart/widgets/cart_product_list_tile.dart';
import 'package:e_commerce/modules/cart/widgets/checkout_modal_sheet.dart';
import 'package:e_commerce/modules/cart/widgets/total_price_text.dart';
import 'package:e_commerce/responsive/responsive_utils.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/components/my_error_widget.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CartCubit>();
    final cart = CartModel.getInstance();

    return Scaffold(
      appBar: AppBar(
        title: const MyText(AppStrings.cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: cart.isEmpty
          ? null
          : SizedBox(
              width: 96,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const CheckoutModalSheet(),
                  );
                },
                child: const MyText(AppStrings.checkout),
              ),
            ),
      body: cart.isEmpty
          ? const MyErrorWidget(message: AppStrings.emptyCart)
          : Center(
              child: MyCard(
                margin: const EdgeInsets.all(16),
                width: context.isMobileScreen ? double.infinity : 500,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  children: [
                    MyText(
                      AppStrings.products,
                      style: context.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    for (final product in cart.unique) ...[
                      RepositoryProvider.value(
                        value: product,
                        child: const CartProductListTile(),
                      ),
                      const Divider(thickness: 3),
                    ],
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: MyText(
                        '${AppStrings.total}: '
                        '\$${cart.price.toStringAsFixed(2)}',
                        style: context.textTheme.subtitle1,
                      ),
                    ),
                    const Divider(thickness: 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: MyText(
                        '${AppStrings.shippingCost}: '
                        '\$${55.toStringAsFixed(2)}',
                        style: context.textTheme.subtitle1,
                      ),
                    ),
                    const Divider(thickness: 3),
                    const TotalPriceText(),
                    const Divider(thickness: 3),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
    );
  }
}
