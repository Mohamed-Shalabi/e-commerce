import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCouponDialog extends StatelessWidget {
  const AddCouponDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CartCubit>();
    return AlertDialog(
      title: const MyText(AppStrings.coupon),
      content: TextFormField(
        controller: viewModel.couponController,
        decoration: const InputDecoration(
          label: MyText(AppStrings.coupon),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          value ??= '';
          if (value.isEmpty) {
            return AppStrings.couponValidationText;
          }

          return null;
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            viewModel.applyCoupon();
            context.pop();
          },
          child: const MyText(AppStrings.applyCoupon),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const MyText(AppStrings.cancel),
        ),
      ],
    );
  }
}
