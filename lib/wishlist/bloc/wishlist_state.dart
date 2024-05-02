part of 'wishlist_bloc.dart';


abstract class WishlistState {}
abstract class WishlistActionState extends WishlistState{}

class WishlistInitial extends WishlistState {}

class WishlistLoadSuccessState extends WishlistState{
  final List<GroceryItem> groceryItemList;
  WishlistLoadSuccessState({
    required this.groceryItemList
  });
}

class WishListToHomeNavSuccessState extends WishlistActionState{}

