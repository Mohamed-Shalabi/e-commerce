import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/cart/blocs/cart_product_view_model.dart';
import 'package:e_commerce/modules/cart/widgets/add_coupon_dialog.dart';
import 'package:e_commerce/modules/cart/widgets/cart_product_list_tile.dart';
import 'package:e_commerce/modules/cart/widgets/checkout_modal_sheet.dart';
import 'package:e_commerce/modules/cart/widgets/total_price_text.dart';
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
    final cart = viewModel.cart;

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
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    MyErrorWidget(message: AppStrings.emptyCart),
                  ],
                ),
              ],
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              children: [
                MyText(
                  AppStrings.products,
                  style: context.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                for (final product in cart) ...[
                  RepositoryProvider(
                    create: (_) => CartProductViewModel(product: product),
                    child: const CartProductListTile(),
                  ),
                  const Divider(thickness: 3),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: MyText(
                    '${AppStrings.total}: '
                    '\$${cart.priceBeforeDiscount.toStringAsFixed(2)}',
                    style: context.textTheme.subtitle1,
                  ),
                ),
                const Divider(thickness: 3),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is ApplyOrRemoveCouponLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          '${AppStrings.discount}: '
                          '\$${cart.coupon.discount.toStringAsFixed(2)}',
                          style: context.textTheme.subtitle1,
                        ),
                        TextButton(
                          onPressed: () {
                            if (cart.coupon.coupon.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: context.read<CartCubit>(),
                                    child: const AddCouponDialog(),
                                  );
                                },
                              );
                            } else {
                              viewModel.removeCoupon();
                            }
                          },
                          child: MyText(
                            cart.coupon.coupon.isNotEmpty
                                ? AppStrings.removeCoupon
                                : AppStrings.applyCoupon,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const Divider(thickness: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: MyText(
                    // TODO: make the shipping cost dynamic
                    '${AppStrings.shippingCost}: 55',
                    style: context.textTheme.subtitle1,
                  ),
                ),
                const Divider(thickness: 3),
                const TotalPriceText(),
                const Divider(thickness: 3),
                const SizedBox(height: 48),
              ],
            ),
    );
  }
}
