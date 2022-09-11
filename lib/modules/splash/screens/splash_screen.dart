import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/splash/blocs/splash_cubit.dart';
import 'package:e_commerce/modules/splash/splash_repository.dart';
import 'package:e_commerce/modules/splash/widgets/welcome_widget.dart';
import 'package:e_commerce/responsive/responsive_widget.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/functions/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => SplashCubit(SplashRepository()),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case SplashStateLoading:
              break;
            case SplashStateLoggedIn:
              context.read<CartCubit>().updateFormData();

              context.navigateAndRemovePreviousRoutes(
                Routes.mainLayoutRouteName,
              );
              break;
            case SplashStateNotLoggedIn:
              context.navigateAndRemovePreviousRoutes(Routes.loginRouteName);
              break;
          }
        },
        child: Scaffold(
          body: Center(
            child: ResponsiveWidget(
              mobileWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  WelcomeWidget(),
                  SizedBox(height: 32),
                  CircularProgressIndicator(),
                ],
              ),
              tabletWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  WelcomeWidget(),
                  SizedBox(width: 32),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
