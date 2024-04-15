import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march09/data/categories.dart';
import 'package:march09/models/grocery_item.dart';
import 'package:march09/providers/grocerylist_provider.dart';
import 'package:march09/widgets/new_item_screen.dart';
import 'package:http/http.dart' as http;

import 'grocery_list_item.dart';
import 'dart:convert';

class GroceryListWidget extends ConsumerStatefulWidget {
  const GroceryListWidget({super.key});

  @override
  ConsumerState<GroceryListWidget> createState() => _GroceryListWidgetState();
}

class _GroceryListWidgetState extends ConsumerState<GroceryListWidget> {
  List<GroceryItem> groceryList = [];
  bool _isLoading =  true;
  String? _error ;
  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async{
    final url = Uri.https('flutter-training-4d283-default-rtdb.firebaseio.com','shopping-list.json');
    final resp = await http.get(url);
    if(resp.body == 'null'){
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if(resp.statusCode >= 400){
      setState(() {
        _isLoading = false;
        _error = 'Failed to fetch data please try again later!';
      });
      return;
    }

    final Map<String,dynamic> resultList = json.decode(resp.body);
    final List<GroceryItem> tempList = [];
    for (final item in resultList.entries){
      final cat = categories.entries.firstWhere((c) => c.value.categoryName == item.value['category'] ).value;
      tempList.add(GroceryItem(name: item.value['name'],
          id: item.key,
          category: cat,
          quantity: item.value['quantity']));
    }
    setState(() {
      groceryList = tempList;
      _isLoading = false;
    });
  }

  void _deleteItem(GroceryItem item) async{
    int index = groceryList.indexOf(item);
    setState(() {
      groceryList.remove(item);
    });
    final url = Uri.https('flutter-training-4d283-default-rtdb.firebaseio.com','shopping-list/${item.id}.json');
    final resp = await http.delete(url);

    if(resp.statusCode >=400){
       groceryList.insert(index, item);
    }
  }

  void _addITem() async{
   final newITem =  await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewWidgetItem()));
   if(newITem == null) {
     return;
   }
   setState(() {
     groceryList.add(newITem);
   });
  }

  @override
  Widget build(BuildContext context) {

    Widget content = const Center(
      child : Text('No data is available to show')
    );

    if(_isLoading){
      content = Center(
        child: CircularProgressIndicator(),
      );
    }

    if(groceryList.isNotEmpty){
      content =  ListView.builder(
          itemCount: groceryList.length,
          itemBuilder:
              (ctx,ind){
            return Dismissible(key: ValueKey(groceryList[ind].id),
            onDismissed: (direction){
              _deleteItem(groceryList[ind]);
            },
            child: GroceryListITemWidget(item:groceryList[ind]));
          });
    }

    if(_error != null){
      content = Center(
          child : Text(_error!)
      );
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
