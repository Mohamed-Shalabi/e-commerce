import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/cart/screens/cart_page.dart';
import 'package:e_commerce/modules/categories/screens/categories_page.dart';
import 'package:e_commerce/modules/profile/screens/profile_page.dart';
import 'package:e_commerce/modules/search/screens/search_page.dart';
import 'package:e_commerce/modules/wishlist/blocs/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit(BuildContext context) : super(MainLayoutInitial()) {
    context.read<WishlistCubit>().getWishlist();
    context.read<CartCubit>();
  }

  final _screens = const <Widget>[
    CategoriesPage(),
    SearchPage(),
    CartPage(),
    ProfilePage(),
  ];

  var _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(currentIndex) {
    _currentIndex = currentIndex;
    emit(MainLayoutChangedSelectedIndex());
  }

  Widget get currentPage => _screens[currentIndex];
}
