import 'package:e_commerce/modules/auth/widgets/sign_up_form.dart';
import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/cart/widgets/total_price_text.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutModalSheet extends StatelessWidget {
  const CheckoutModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is PlaceOrderSucceeded) {
          context.pop();
          context.showSnackBar(AppStrings.orderDone);
          return;
        }

        if (state is PlaceOrderFailed) {
          context.pop();
          context.showSnackBar(AppStrings.placeOrderFailed);
          return;
        }
      },
      child: DraggableScrollableSheet(
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: ListView(
              controller: scrollController,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                  child: TotalPriceText(),
                ),
                const Divider(thickness: 3),
                const AdditionalInputFormFields<CartCubit>(),
                const SizedBox(height: 24),
                Center(
                  child: MaterialButton(
                    color: context.colorScheme.primary,
                    onPressed: () {
                      context.read<CartCubit>().placeOrderAndClearCart();
                    },
                    child: MyText(
                      AppStrings.checkout,
                      style: context.textTheme.button?.copyWith(
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
