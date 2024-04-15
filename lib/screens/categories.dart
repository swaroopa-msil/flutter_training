import 'package:flutter/material.dart';
import 'package:march09/screens/meals.dart';
import 'package:march09/widgets/category_grid_item.dart';
import 'package:march09/models/categorymodel.dart';
import 'package:march09/data/dummy_data.dart';

import '../models/mealsModel.dart';

class CategoriesScreenWidget extends StatefulWidget{
  const CategoriesScreenWidget({super.key, required this.availableMealsList});
  final List<Meal> availableMealsList;

  @override
  State<CategoriesScreenWidget> createState() => _CategoriesScreenWidgetState();
}

class _CategoriesScreenWidgetState extends State<CategoriesScreenWidget>  with SingleTickerProviderStateMixin{
  late AnimationController _animController;
  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this,
    duration: const Duration(milliseconds: 300),
    lowerBound: 0,
    upperBound: 1);

    _animController.forward();
  }
  void _selectCategory(BuildContext context,CategoryModel category){
    final selectedMeals = widget.availableMealsList.where((meal) => meal.categories.contains(category.id) ).toList();
    Navigator.of(context).push(
        MaterialPageRoute(builder:
            (ctx) =>  MealsScreen(header: category.title, mealsList: selectedMeals)
        )
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _animController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio: 3/2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            for(final category in availableCategories)
              CategoryItemWidget(
                  category,
                      (){
                    _selectCategory(context,category);
                  }
              )
          ],
        ),
        builder: (context,child){
      return SlideTransition(position :Tween(begin: const Offset(0,0.3), end:  const Offset(0,0)).animate(CurvedAnimation(parent: _animController, curve: Curves.easeInOut)),
          child: child);
           //  return Padding(child: child,padding: EdgeInsets.only(top: 100 - _animController.value * 100));
    });
  }
}
