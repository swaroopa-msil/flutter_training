

import '../../model/grocery_item.dart';

abstract class WishlistEvent {}

class RemoveFromWishlistEvent extends WishlistEvent{
   GroceryItem groceryItem;
   RemoveFromWishlistEvent(this.groceryItem);
}

class WishListLoadedSuccessEvent extends WishlistEvent{

}

class WishListNavToHomeSuccessEvent extends WishlistEvent{
}




