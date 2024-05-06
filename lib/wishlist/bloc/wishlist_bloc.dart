import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:march09/data/groceries_data_list.dart';
import 'package:march09/model/grocery_item.dart';
import 'package:march09/wishlist/bloc/wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishListLoadedSuccessEvent>((event, emit) {
       emit(WishlistLoadSuccessState(groceryItemList: GroceryData.groceryWishList));
    });
    on<RemoveFromWishlistEvent>((event, emit){
      GroceryData.groceryWishList.remove(event.groceryItem);
      emit(WishlistLoadSuccessState(groceryItemList: GroceryData.groceryWishList));
    });
  }
}
