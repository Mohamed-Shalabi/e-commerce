part of 'wishlist_cubit.dart';

@immutable
abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistToggleProductLoading extends WishlistState {
  final int productId;

  WishlistToggleProductLoading({required this.productId});
}

class WishlistToggleProductDone extends WishlistState {}

class WishlistFetched extends WishlistState {}

class WishlistFetchFailed extends WishlistState {
  final String message;

  WishlistFetchFailed({required this.message});
}
