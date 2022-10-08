import 'package:e_commerce/core/components/my_error_widget.dart';
import 'package:e_commerce/core/components/my_text.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/wishlist/blocs/wishlist_cubit.dart';
import 'package:e_commerce/modules/wishlist/widgets/wishlist_products_responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.watch<WishlistCubit>().products;

    return Scaffold(
      appBar: AppBar(
        title: const MyText(AppStrings.wishlist),
      ),
      body: products.isEmpty
          ? const MyErrorWidget(message: AppStrings.emptyWishlist)
          : const WishlistProductsResponsiveWidget(),
    );
  }
}
