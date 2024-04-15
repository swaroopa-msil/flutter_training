import 'package:flutter/material.dart';
import 'package:march09/models/grocery_item.dart';

class GroceryListITemWidget extends StatelessWidget {
  const GroceryListITemWidget({super.key,required this.item});

  final GroceryItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      leading: Container(
        height: 24,
        width: 24,
        color: item.category.colorCode,
      ),
      trailing: Text(item.quantity.toString()),
    );
  }
}
