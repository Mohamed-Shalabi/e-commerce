import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/main_layout/widgets/mobile_main_layout_body.dart';
import 'package:e_commerce/modules/main_layout/widgets/tablet_main_layout_body.dart';
import 'package:e_commerce/responsive/responsive_widget.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartFetchError) {
          context.showSnackBar(state.message);
        }
      },
      child: const ResponsiveWidget(
        mobileWidget: MobileMainLayoutBody(),
        tabletWidget: TabletMainLayoutBody(),
      ),
    );
  }
}
