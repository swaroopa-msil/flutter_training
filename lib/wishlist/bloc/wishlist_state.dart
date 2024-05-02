part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}
abstract class WishlistActionState {}

class WishlistInitial extends WishlistState {}

class WishlistLoadSuccessState extends WishlistState{
  final List<GroceryItem> groceryItemList;
  WishlistLoadSuccessState({
    required this.groceryItemList
  });
}

