import 'package:flutter/material.dart';
import 'package:march09/models/mealsModel.dart';
import 'package:march09/screens/meals_details.dart';
import 'package:march09/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({this.header, required this.mealsList, super.key});

  final String? header;

  final List<Meal> mealsList;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.push(context,
        MaterialPageRoute(builder: (cxt) => MealDetailsScreen(meal: meal)));
  }

  Widget getBodyWidget(BuildContext context) {
    Widget content = Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('No data available',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground)),
        const SizedBox(height: 10),
        Text(
          'Try selecting another category',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ],
    ));
    if (mealsList.isNotEmpty) {
      content = ListView.builder(
          itemCount: mealsList.length,
          itemBuilder: (ctx, index) => MealItemWidget(
              meal: mealsList[index],
              onSelectMeal: (meal) {
                selectMeal(ctx, meal);
              }));
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    final content = getBodyWidget(context);

    // remove appbar for my fav and category screens
    if (header == null) {
      return content;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(header!),
        ),
        body: content);
  }
}
