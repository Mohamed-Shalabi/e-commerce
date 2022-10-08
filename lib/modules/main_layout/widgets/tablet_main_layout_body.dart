import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/main_layout/blocs/main_layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabletMainLayoutBody extends StatelessWidget {
  const TabletMainLayoutBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainLayoutCubit>();
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Row(
        children: [
          NavigationRail(
            onDestinationSelected: (value) => viewModel.currentIndex = value,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.apps),
                label: Text(AppStrings.categories),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search),
                label: Text(AppStrings.search),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.shopping_cart_outlined),
                label: Text(AppStrings.cart),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                label: Text(AppStrings.profile),
              ),
            ],
            selectedIndex: viewModel.currentIndex,
          ),
          Expanded(child: viewModel.currentPage),
        ],
      ),
    );
  }
}
