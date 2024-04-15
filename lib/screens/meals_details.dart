import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march09/provider/favourite_provider.dart';

import '../models/mealsModel.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  void showSnackBar(bool isAdded, BuildContext context) {
    String message = 'Successfully removed from Favourites';
    if (isAdded) {
      message = 'Successfully added to Favourites';
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Color getColor(bool isAdded) {
    Color starColor = Colors.white;
    if (isAdded) {
      starColor = Colors.blue;
    }
    return starColor;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favMeal = ref.watch(favoriteProvider);
    bool isMealFav = favMeal.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                final isAdded = ref
                    .read(favoriteProvider.notifier)
                    .favMealToggleStatus(meal);
                showSnackBar(isAdded, context);
              },
              icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                      child: child,
                    );
                  },
                  child: Icon(
                    Icons.star,
                    color: getColor(isMealFav),
                    key: ValueKey(isMealFav),
                  )))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: meal.id,
                child: Image.network(meal.imageUrl,
                    width: double.infinity, fit: BoxFit.cover, height: 300)),
            const SizedBox(height: 14),
            Text(
              'Ingrediants',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            for (final ingredient in meal.ingredients)
              Text(ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(height: 14),
            Text(
              'Steps',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            for (final step in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Text(
                  step,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                  textAlign: TextAlign.center,
                ),
              )
          ],
        ),
      ),
    );
  }
}
