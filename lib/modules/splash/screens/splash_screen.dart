import 'package:e_commerce/modules/auth/blocs/shipping/shipping_data_provider.dart';
import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/splash/blocs/splash_cubit.dart';
import 'package:e_commerce/modules/splash/widgets/welcome_widget.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/components/my_error_widget.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/functions/navigate.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:e_commerce/shared/utils/media_query_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case SplashStateLoading:
            break;
          case SplashStateError:
            context.showSnackBar(AppStrings.connectionError);
            break;
          case SplashStateLoggedIn:
            context.read<ShippingDataProvider>().updateShippingData();
            context.read<CartCubit>().initCart();
            context.navigateAndRemovePreviousRoutes(
              Routes.mainLayoutRouteName,
            );
            break;
          case SplashStateNotLoggedIn:
            context.navigateAndRemovePreviousRoutes(Routes.loginRouteName);
            break;
        }
      },
      builder: (BuildContext context, SplashState state) {
        if (state is SplashStateError) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyErrorWidget(message: state.message),
                TextButton(
                  onPressed: () {
                    context.read<SplashCubit>().getData();
                  },
                  child: const MyText(AppStrings.tryAgain),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: context.isPortrait
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      WelcomeWidget(),
                      SizedBox(height: 32),
                      CircularProgressIndicator(),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      WelcomeWidget(),
                      SizedBox(width: 32),
                      CircularProgressIndicator(),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
