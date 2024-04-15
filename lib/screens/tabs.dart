import 'package:flutter/material.dart';
import 'package:march09/screens/categories.dart';
import 'package:march09/screens/filter.dart';
import 'package:march09/screens/meals.dart';
import 'package:march09/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/favourite_provider.dart';
import '../provider/filters_provider.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

const filterMap = {
  Filter.vegetarian: false,
  Filter.vegan: false,
  Filter.glutenFree: false,
  Filter.lactoseFree: false
};

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;
  String _activePageHeader = 'Categories';

  void setSelectedPageIndex(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  Widget getBodyWidget() {
    Widget content = CategoriesScreenWidget(
        availableMealsList: ref.watch(filterMealProvider));
    if (_selectedPageIndex == 1) {
      final favMeals = ref.watch(favoriteProvider);
      _activePageHeader = 'Favourite Meals';
      content = MealsScreen(mealsList: favMeals);
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_activePageHeader),
      ),
      drawer: MainDrawerWidget(onSelectScreen: _setScreen),
      body: getBodyWidget(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: setSelectedPageIndex,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'My Favourites')
        ],
      ),
    );
  }
}
