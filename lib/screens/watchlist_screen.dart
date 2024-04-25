import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:march09/providers/data_List_change_provider.dart';
import 'package:provider/provider.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});


  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {

  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Widget  content = Center(child: Text('No data in watchlist',style: TextStyle(color: Theme.of(context).colorScheme.onBackground)));
    return Consumer<DataListChangeProvider>(builder:
        (BuildContext context, DataListChangeProvider value, Widget? child) {
      return
        Scaffold(
          body: Center(
              child: Column(
                children: [
              Expanded( child: value.dataList.isEmpty ? content :
                     ListView.builder( itemCount: value.dataList.length,
                        itemBuilder: (context,index){
                          return Dismissible(
                            key: Key(value.dataList[index]),
                            onDismissed: (direction){
                              value.removeFromList(value.dataList[index]);
                            },
                            child: ListTile(
                              leading: IconButton(
                                onPressed: (){
                                  value.addToFav(value.dataList[index]);
                                },
                                icon: Icon(Icons.star, color: value.isInFav(value.dataList[index]) ? Colors.green : Colors.grey),
                              ),
                              title:Text(value.dataList[index]),
                            ),
                          );
                        }),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                              labelText: 'Enter the item to watchlist'
                          )
                        ),
                      ),
                      IconButton(onPressed: (){
                        value.addToList( _controller.text);
                        _controller.clear();
                      }, icon: const Icon(Icons.add))
                    ],
                  )
                ],
              )
          ),
        );},

    );
  }
}
