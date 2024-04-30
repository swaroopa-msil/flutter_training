import 'package:flutter/material.dart';

import '../providers/data_List_change_provider.dart';
class ItemListWidget extends StatefulWidget {
  const ItemListWidget({super.key, required this.provider});
  final  DataListChangeProvider provider;
  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder( itemCount: widget.provider.dataList.length,
        itemBuilder: (context,index){
          return Dismissible(
            key: Key(widget.provider.dataList[index]),
            onDismissed: (direction){
              widget.provider.removeFromList(widget.provider.dataList[index]);
            },
            child: ListTile(
              leading: IconButton(
                onPressed: (){
                  widget.provider.addToFav(widget.provider.dataList[index]);
                },
                icon: Icon(Icons.star, color: widget.provider.isInFav(widget.provider.dataList[index]) ? Colors.green : Colors.grey),
              ),
              title:Text(widget.provider.dataList[index]),
            ),
          );
        });
  }
}

