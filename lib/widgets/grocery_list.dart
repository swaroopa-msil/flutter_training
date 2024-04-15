import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march09/data/dummy_data.dart';
import 'package:march09/models/grocery_item.dart';
import 'package:march09/providers/grocerylist_provider.dart';
import 'package:march09/widgets/new_item_screen.dart';

import 'grocery_list_item.dart';

class GroceryListWidget extends ConsumerStatefulWidget {
  const GroceryListWidget({super.key});

  @override
  ConsumerState<GroceryListWidget> createState() => _GroceryListWidgetState();
}

class _GroceryListWidgetState extends ConsumerState<GroceryListWidget> {
  void _addITem() async{
    final newItem = await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => NewWidgetItem()));
  if(newItem != null){
      ref.read(grocerylistProvider.notifier).addToGroceries(newItem);
  }
  }

  @override
  Widget build(BuildContext context) {
     final list = ref.watch(grocerylistProvider);
    Widget content = const Center(
      child : Text('No data is available to show')
    );

    if(list.isNotEmpty){
      content =  ListView.builder(
          itemCount: list.length,
          itemBuilder:
              (ctx,ind){
            return Dismissible(key: ValueKey(list[ind].id),
            onDismissed: (direction){
              ref.read(grocerylistProvider.notifier).addToGroceries(list[ind]);
            },
            child: GroceryListITemWidget(item:list[ind]));
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(onPressed: _addITem,
              icon: const Icon(Icons.add))
        ],
      ),
      body:content
    );
  }
}
