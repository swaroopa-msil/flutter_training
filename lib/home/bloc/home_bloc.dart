import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:march09/model/grocery_item.dart';
import 'package:march09/data/groceries_data_list.dart';
import 'package:meta/meta.dart';

import 'home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<ItemWishListIconClickEvent>(itemWishListIconClickEvent);
    on<WishListBarClickEvent>(wishListBarClickEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async{
     emit(HomeLoadingState());
     await Future.delayed(const Duration(seconds: 3));
     GroceryData.groceryList.addAll(GroceryData.groceryDataList.map((e) => GroceryItem(title: e['name']??"",
         id: e['id']??"",
         category: e['category']??"",
         price:e['price']??"",
         quantity: e['quantity']??"",
         url: e['url']??"",
         units: e['unit']??"")).toList());
     addToWishListed();
     emit(HomeLoadingSuccessState(groceryItem: GroceryData.groceryList));
  }

  void addToWishListed(){
    for(var item in GroceryData.groceryList){
      if(GroceryData.groceryWishList.contains(item)){
        item.isWishListed =  true;
      }else{
        item.isWishListed =  false;
      }
    }
  }

  FutureOr<void> itemWishListIconClickEvent(ItemWishListIconClickEvent event, Emitter<HomeState> emit) {
    if(GroceryData.groceryWishList.contains(event.groceryItem)){
      GroceryData.groceryWishList.remove(event.groceryItem);
      addToWishListed();
      emit(AddedOrRemovedWishListItemActionState('Successfully removed item from Wishlist'));
    }else{
      event.groceryItem.isWishListed == true;
      GroceryData.groceryWishList.add(event.groceryItem);
      addToWishListed();
      emit(AddedOrRemovedWishListItemActionState('Successfully added item to Wishlist'));
    }
    emit(HomeLoadingSuccessState(groceryItem:GroceryData.groceryList));
  }

  FutureOr<void> wishListBarClickEvent(WishListBarClickEvent event, Emitter<HomeState> emit) {
    emit(HomeToWishListNavigateState());
  }


}
