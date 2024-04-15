import 'package:flutter/material.dart';
import 'package:march09/models/categorymodel.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget(this.category, this.cardTapped, {super.key});

  final CategoryModel category;
  final void Function() cardTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cardTapped,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                category.color.withOpacity(0.55),
                category.color.withOpacity(0.9),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Text(
            category.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )),
    );
  }
}
