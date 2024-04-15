import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march09/provider/meals_provider.dart';


enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}

class FilterNotifier extends StateNotifier<Map<Filter,bool>>{
  FilterNotifier():super({
    Filter.vegan : false,
    Filter.vegetarian : false,
    Filter.lactoseFree : false,
    Filter.glutenFree : false,
  });

  void setFilter(Filter filter,bool isActive){
    state = {
      ...state, filter:isActive
    };
  }

  void setFilters(Map<Filter,bool> chosen){
     state = chosen;
  }

}

final filterProvider = StateNotifierProvider<FilterNotifier,Map<Filter,bool>>((ref){
  return FilterNotifier();
});

final filterMealProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filter = ref.watch(filterProvider);
  return meals.where((element) {
    if(filter[Filter.glutenFree]! && !element.isGlutenFree){
      return false;
    }
    if(filter[Filter.vegan]! && !element.isVegan){
      return false;
    }
    if(filter[Filter.lactoseFree]! && !element.isLactoseFree){
      return false;
    }
    if(filter[Filter.vegetarian]! && !element.isVegetarian){
      return false;
    }
    return true;
  }
  ).toList();
});
