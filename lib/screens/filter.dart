import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  Widget getSwitchListTile(
      BuildContext context, WidgetRef ref, Filter filterCase, String title) {
    final activeFilter = ref.watch(filterProvider);
    return SwitchListTile(
      value: activeFilter[filterCase]!,
      onChanged: (isChecked) {
        ref.read(filterProvider.notifier).setFilter(filterCase, isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        'Only includes $title food',
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: Column(
        children: [
          getSwitchListTile(context, ref, Filter.glutenFree, 'Gluten-free'),
          getSwitchListTile(context, ref, Filter.lactoseFree, 'Lactose-free'),
          getSwitchListTile(context, ref, Filter.vegetarian, 'Vegetarian'),
          getSwitchListTile(context, ref, Filter.vegan, 'Vegan')
        ],
      ),
    );
  }
}
