import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:march09/providers/data_List_change_provider.dart';
import 'package:march09/utils/app_constants.dart';
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

  Widget _getWatchList(DataListChangeProvider provider,int index){
    final dataItem = provider.dataList[index];
          return Dismissible(
            key: Key(dataItem),
            onDismissed: (direction){
              provider.removeFromList(dataItem);
            },
            child: ListTile(
              leading: IconButton(
                onPressed: (){
                  provider.addToFav(dataItem);
                },
                icon: Icon(Icons.star, color: provider.isInFav(dataItem) ? Colors.green : Colors.grey),
              ),
              title:Text(dataItem),
            ),
          );
  }

  Widget getInputItem(DataListChangeProvider provider){
    return  Row(
      children: [
        Expanded(
          child: TextField(
              controller: _controller,
              decoration:  InputDecoration(
                  labelText: AppConstants.enterTextLabel
              )
          ),
        ),
        IconButton(onPressed: (){
          provider.addToList( _controller.text);
          _controller.clear();
        }, icon: const Icon(Icons.add))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget  content = Center(child: Text(AppConstants.noDataLabel,style: TextStyle(color: Theme.of(context).colorScheme.onBackground)));
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
                          return _getWatchList(value,index);
                        }),
                  ),
                  getInputItem(value)
                ],
              )
          ),
        );},

    );
  }
}
