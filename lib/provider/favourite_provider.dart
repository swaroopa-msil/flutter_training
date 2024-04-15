import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mealsModel.dart';


class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{

  FavoriteMealsNotifier(): super([]);
  
  bool favMealToggleStatus(Meal meal){
    final isFavAdded = state.contains(meal);
    if(isFavAdded){
      state = state.where((m) => meal.id != m.id).toList();
      return false;
    }else{
      state = [...state,meal];
      return true;
    }
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteMealsNotifier,List<Meal>>((ref)  {
  return FavoriteMealsNotifier();
});