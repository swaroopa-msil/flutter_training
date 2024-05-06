part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{

}
class WishListBarClickEvent extends HomeEvent{

}
class ItemWishListIconClickEvent extends HomeEvent{
    final GroceryItem groceryItem;
    ItemWishListIconClickEvent({
      required this.groceryItem
});
}
class RemovedWishlistItemClickEvent extends HomeEvent{
  final GroceryItem groceryItem;
  RemovedWishlistItemClickEvent({
    required this.groceryItem
  });
}
