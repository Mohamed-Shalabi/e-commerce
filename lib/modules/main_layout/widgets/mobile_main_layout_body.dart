import 'package:e_commerce/modules/main_layout/blocs/main_layout_cubit.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileMainLayoutBody extends StatelessWidget {
  const MobileMainLayoutBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainLayoutCubit>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: context.colorScheme.surface,
        type: BottomNavigationBarType.fixed,
        currentIndex: viewModel.currentIndex,
        onTap: (int index) {
          viewModel.currentIndex = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: AppStrings.categories,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: AppStrings.search,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: AppStrings.cart,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: AppStrings.profile,
          ),
        ],
      ),
      body: viewModel.currentPage,
    );
  }
}
