import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march09/home/bloc/home_bloc.dart';
import 'package:march09/model/grocery_item.dart';
import 'package:march09/wishlist/bloc/wishlist_bloc.dart';

import '../wishlist/bloc/wishlist_event.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget(
      {super.key, required this.groceryItem, required this.bloc,required this.hBloc});

  final GroceryItem groceryItem;
  final Bloc bloc;
  final HomeBloc hBloc;

  void getButtonAction() {
    if (bloc is HomeBloc) {
      bloc.add(ItemWishListIconClickEvent(groceryItem: groceryItem));
    } else if (bloc is WishlistBloc) {
      bloc.add(RemoveFromWishlistEvent(groceryItem));
      hBloc.add(RemovedWishlistItemClickEvent(groceryItem: groceryItem));
    }
  }

  Widget getRow(String firstTitle,String secondTitle, double size,FontWeight weight){
    return Row(
      children: [
        Text('Name : $firstTitle',
            style:  TextStyle(
                fontWeight: weight, fontSize: size)),
        const Spacer(),
        Text('Category : $secondTitle',
            style:  TextStyle(
                fontWeight: weight, fontSize: size)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          Image(
            image: NetworkImage(groceryItem.url),
            width: double.infinity,
            fit: BoxFit.fitWidth,
            height: 300,
          ),
          getRow(groceryItem.title,groceryItem.category,18,FontWeight.bold),
          getRow(groceryItem.quantity,groceryItem.units,16,FontWeight.w800),
          Row(
            children: [
              Text('Price : ${groceryItem.price}',style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(width: 5),
              IconButton(
                  onPressed: getButtonAction,
                  icon: Icon(
                    Icons.favorite,
                    color: groceryItem.isWishListed ? Colors.red : Colors.grey,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
