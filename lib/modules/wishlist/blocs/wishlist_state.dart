part of 'wishlist_cubit.dart';

@immutable
abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistToggleProductLoading extends WishlistState {}

class WishlistToggleProductDone extends WishlistState {}

class WishlistToggleProductFailed extends WishlistState {
  final String message;

  WishlistToggleProductFailed({required this.message});
}

class WishlistFetched extends WishlistState {}

class WishlistFetchFailed extends WishlistState {
  final String message;

  WishlistFetchFailed({required this.message});
}
