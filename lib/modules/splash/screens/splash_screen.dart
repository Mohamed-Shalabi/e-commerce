import 'package:e_commerce/modules/splash/blocs/splash_cubit.dart';
import 'package:e_commerce/modules/splash/splash_repository.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/media_query_utils.dart';
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
          switch (state.state) {
            case SplashStates.loading:
              break;
            case SplashStates.userLoggedIn:
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.mainLayoutRouteName,
                (_) => true,
              );
              break;
            case SplashStates.userNotLoggedIn:
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.loginRouteName,
                (_) => true,
              );
              break;
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: context.colorScheme.primary,
                  radius: context.screenWidth / 2 - 16,
                  child: CircleAvatar(
                    backgroundColor: context.colorScheme.surface,
                    radius: context.screenWidth / 2 - 42,
                    child: CircleAvatar(
                      backgroundColor: context.colorScheme.secondary,
                      radius: context.screenWidth / 2 - 56,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyText(
                          'Welcome to Market App!',
                          textAlign: TextAlign.center,
                          textStyle: context.textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
