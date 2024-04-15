import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:march09/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/mealsModel.dart';

class MealItemWidget extends StatelessWidget {
  const MealItemWidget(
      {super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;

  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name.replaceFirst(
        meal.complexity.name[0], meal.complexity.name[0].toUpperCase());
  }

  String get affordabilityText {
    return meal.affordability.name.replaceFirst(
        meal.affordability.name[0], meal.affordability.name[0].toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(
                              label: '${meal.duration} min',
                              icon: Icons.schedule),
                          const SizedBox(width: 12),
                          MealItemTrait(
                              label: complexityText, icon: Icons.work),
                          const SizedBox(width: 12),
                          MealItemTrait(
                              label: affordabilityText, icon: Icons.money),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
