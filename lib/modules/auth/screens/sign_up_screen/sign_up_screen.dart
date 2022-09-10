import 'package:e_commerce/modules/auth/blocs/sign_up/sign_up_cubit.dart';
import 'package:e_commerce/modules/auth/screens/sign_up_screen/mobile_sign_up_screen_body.dart';
import 'package:e_commerce/modules/auth/screens/sign_up_screen/tablet_sign_up_screen_body.dart';
import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/responsive/responsive_Builder.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/functions/navigate.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(
          AppStrings.signUp,
        ),
      ),
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailed) {
            context.showSnackBar(state.message);
          }

          if (state is SignUpSucceeded) {
            context.read<CartCubit>().updateFormData();
            context.navigateAndRemovePreviousRoutes(
              Routes.mainLayoutRouteName,
            );
          }
        },
        builder: (context, state) {
          if (state is SignUpLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const ResponsiveWidget(
            mobileWidget: MobileSignUpScreenBody(),
            tabletWidget: TabletSignUpScreenBody(),
          );
        },
      ),
    );
  }
}
