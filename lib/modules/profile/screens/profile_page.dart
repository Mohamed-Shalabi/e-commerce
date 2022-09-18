import 'package:e_commerce/modules/profile/blocs/profile_cubit.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLogoutDone) {
            context.navigateAndRemovePreviousRoutes(Routes.loginRouteName);
          }

          if (state is ProfileLogoutFailed) {
            context.showSnackBar(state.message);
          }
        },
        builder: (context, state) {
          final viewModel = context.read<ProfileCubit>();
          final user = viewModel.user;

          return Scaffold(
            appBar: AppBar(
              title: MyText(user.name),
            ),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              children: [
                MyCard(
                  height: 48,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: state is ProfileLogoutLoading
                        ? const Center(child: CircularProgressIndicator())
                        : TextButton(
                            onPressed: viewModel.logout,
                            child: const MyText(AppStrings.logout),
                          ),
                  ),
                ),
                // const SizedBox(height: 16),
                // MyCard(
                //   height: 48,
                //   child: SizedBox(
                //     width: double.infinity,
                //     height: double.infinity,
                //     child: TextButton(
                //       onPressed: () {},
                //       child: const MyText(AppStrings.profile),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 16),
                MyCard(
                  height: 48,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        context.read<AppThemesCubit>().toggleIsLight();
                      },
                      child: const MyText(AppStrings.toggleDarkMode),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                MyCard(
                  height: 48,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        context.navigate(Routes.myOrdersRouteName);
                      },
                      child: const MyText(AppStrings.myOrders),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                MyCard(
                  height: 48,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        context.navigate(Routes.wishlistRouteName);
                      },
                      child: const MyText(AppStrings.wishlist),
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
