import 'package:e_commerce/modules/profile/blocs/profile_cubit.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/components/my_text.dart';
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
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final user = context.read<ProfileCubit>().user;
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
                    child: TextButton(
                      onPressed: () {},
                      child: const MyText(AppStrings.logout),
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
                      onPressed: () {},
                      child: const MyText(AppStrings.profile),
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
