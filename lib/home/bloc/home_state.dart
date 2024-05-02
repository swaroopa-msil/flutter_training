import 'package:march09/model/grocery_item.dart';
import 'package:march09/model/grocery_item.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState{}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{

}
class HomeLoadingSuccessState extends HomeState{
  List<GroceryItem> groceryItem;
  HomeLoadingSuccessState({
    required this.groceryItem
});
}
class HomeErrorState extends HomeState{
  final String errorMessage;
  HomeErrorState(this.errorMessage);
}

class HomeToWishListNavigateState extends HomeActionState{

}
class AddedOrRemovedWishListItemActionState extends HomeActionState{
  final String message;
  AddedOrRemovedWishListItemActionState(this.message);
}


