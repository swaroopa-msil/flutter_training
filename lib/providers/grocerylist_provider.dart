

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march09/models/grocery_item.dart';

class AddToGroceryNotifier extends StateNotifier<List<GroceryItem>>{

  AddToGroceryNotifier(): super([]);

  void addToGroceries(GroceryItem item){
     final flag = state.contains(item);
     if(flag){ // removing
       state = state.where((it) => it.id != item.id ).toList();
     }else{ // adding
      state = [...state,item];
     }
  }

}

final grocerylistProvider = StateNotifierProvider<AddToGroceryNotifier,List<GroceryItem>>((ref) => AddToGroceryNotifier());
