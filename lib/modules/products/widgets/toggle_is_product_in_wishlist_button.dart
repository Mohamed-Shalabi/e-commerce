import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/wishlist/blocs/wishlist_cubit.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleIsProductInWishlistButton<T extends BaseProductModel>
    extends StatelessWidget {
  const ToggleIsProductInWishlistButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(T != dynamic, 'Type T cannot be empty');
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {
        if (state is WishlistToggleProductFailed) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        final product = context.read<T>();

        if (context.read<WishlistCubit>().isProductLoading(product.id)) {
          return const CircularProgressIndicator();
        }

        final wishlistCubit = context.watch<WishlistCubit>();
        final products = wishlistCubit.products;
        return IconButton(
          onPressed: () {
            wishlistCubit.toggleIsProductInWishlist(product.id);
          },
          icon: Icon(
            product.isInWishlist(products)
                ? Icons.favorite
                : Icons.favorite_border,
            color: AppColors.favourites,
          ),
        );
      },
    );
  }
}
