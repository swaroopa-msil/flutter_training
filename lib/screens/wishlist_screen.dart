import 'package:flutter/material.dart';
import 'package:march09/providers/data_List_change_provider.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  @override
  Widget build(BuildContext context) {
    Widget content =  Text('Empty Wishlist',style: TextStyle(color: Theme.of(context).colorScheme.onBackground));
    return Consumer<DataListChangeProvider>(
      builder: (BuildContext context, DataListChangeProvider value, Widget? child) {
        return Scaffold(
          body: Center(
              child: value.favDataList.isEmpty ? content : ListView.builder(
                itemCount: value.favDataList.length,
                  itemBuilder: (content,index){
                   return Dismissible(
                     key: Key(value.favDataList[index]),
                     onDismissed: (direction){
                       value.removeFromFav(value.favDataList[index]);
                     },
                     child: ListTile(
                        title: Text(value.favDataList[index]),
                       leading: IconButton(
                         onPressed: (){
                           value.removeFromFav(value.favDataList[index]);
                         },
                         icon: const Icon(Icons.star, color: Colors.green),
                       ),
                      ),
                   );
                  })
          ),
        );
      },
    );
  }
}
