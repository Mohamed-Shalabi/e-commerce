import 'package:e_commerce/modules/auth/blocs/shipping/shipping_data_provider.dart';
import 'package:e_commerce/modules/auth/blocs/sign_up/sign_up_cubit.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MaterialButton(
          onPressed: () {
            final signUpCubit = context.read<SignUpCubit>();
            final shippingDataCubit = context.read<ShippingDataProvider>();

            final isSignUpFormValidated = signUpCubit.isSignUpFormValidated;
            final isShippingDataFormValidated = shippingDataCubit.isShippingDataFormValidated;
            if (isSignUpFormValidated && isShippingDataFormValidated) {
              signUpCubit.signUp(
                shippingDataCubit.phoneController.text.trim(),
                shippingDataCubit.countryController.text.trim(),
                shippingDataCubit.cityController.text.trim(),
                shippingDataCubit.addressController.text.trim(),
              );
            }
          },
          color: context.colorScheme.secondary,
          child: MyText(
            AppStrings.signUp,
            style: TextStyle(color: context.colorScheme.onSecondary),
          ),
        ),
      ),
    );
  }
}
