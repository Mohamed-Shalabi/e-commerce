import 'package:e_commerce/modules/products/widgets/products_responsive_widget.dart';
import 'package:e_commerce/modules/wishlist/blocs/wishlist_cubit.dart';
import 'package:e_commerce/shared/components/my_error_widget.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistCubit>().wishlist;

    return Scaffold(
      appBar: AppBar(
        title: const MyText(AppStrings.wishlist),
      ),
      body: wishlist.isEmpty
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              MyErrorWidget(message: AppStrings.emptyWishlist)
            ],
          )
        ],
      )
          : const ProductsResponsiveWidget<WishlistCubit>(),
    );
  }
}
