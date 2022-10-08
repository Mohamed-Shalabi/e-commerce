import 'package:e_commerce/core/components/show_snack_bar.dart';
import 'package:e_commerce/core/functions/navigate.dart';
import 'package:e_commerce/core/responsive/responsive_widget.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/auth/blocs/login/login_cubit.dart';
import 'package:e_commerce/modules/auth/blocs/shipping/shipping_data_provider.dart';
import 'package:e_commerce/modules/auth/screens/login_screen/mobile_login_screen_body.dart';
import 'package:e_commerce/modules/auth/screens/login_screen/tablet_login_screen_body.dart';
import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/wishlist/blocs/wishlist_cubit.dart';
import 'package:e_commerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.login),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, LoginState state) {
          if (state is LoginFailed) {
            context.showSnackBar(state.message);
          }
          if (state is LoginSucceeded) {
            context.read<ShippingDataProvider>().updateShippingData();
            context.read<CartCubit>().initCart();
            context.read<WishlistCubit>().clearWishlist();
            context.navigateAndRemovePreviousRoutes(
              Routes.mainLayoutRouteName,
            );
          }
        },
        builder: (_, LoginState state) {
          if (state is LoginLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const ResponsiveWidget(
            mobileWidget: MobileLoginScreenBody(),
            tabletWidget: TabletLoginScreenBody(),
          );
        },
      ),
    );
  }
}
