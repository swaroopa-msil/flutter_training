import 'package:flutter/material.dart';

class MainDrawerWidget extends StatelessWidget {
  const MainDrawerWidget({super.key, required this.onSelectScreen});

  final void Function(String title) onSelectScreen;

  Widget getListTile(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon,
          size: 26, color: Theme.of(context).colorScheme.onBackground),
      title: Text(title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground, fontSize: 24)),
      onTap: () {
        onSelectScreen(title);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.fastfood,
                    size: 48, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 18),
                Text('Cooking Up!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground))
              ],
            ),
          ),
          getListTile(context, 'Meals', Icons.restaurant),
          getListTile(context, 'Filters', Icons.filter),
        ],
      ),
    );
  }
}
