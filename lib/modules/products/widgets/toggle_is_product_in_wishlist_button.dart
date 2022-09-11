import 'package:e_commerce/modules/products/blocs/single_product/product_view_model.dart';
import 'package:e_commerce/modules/wishlist/blocs/wishlist_cubit.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleIsProductInWishlistButton extends StatelessWidget {
  const ToggleIsProductInWishlistButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {
        if (state is WishlistToggleProductFailed) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        final product = context.read<ProductViewModel>().product;

        if (state is WishlistToggleProductLoading &&
            product.id == state.productId) {
          return const CircularProgressIndicator();
        }

        final wishlistCubit = context.watch<WishlistCubit>();
        final wishlist = wishlistCubit.wishlist;
        return IconButton(
          onPressed: () {
            wishlistCubit.toggleIsProductInWishlist(product.id);
          },
          icon: Icon(
            product.isInWishlist(wishlist)
                ? Icons.favorite
                : Icons.favorite_border,
            color: AppColors.favourites,
          ),
        );
      },
    );
  }
}
