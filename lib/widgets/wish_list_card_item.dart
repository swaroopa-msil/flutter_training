import 'package:flutter/material.dart';
import 'package:march09/home/bloc/home_bloc.dart';
import 'package:march09/model/grocery_item.dart';
import 'package:march09/wishlist/bloc/wishlist_bloc.dart';

import '../wishlist/bloc/wishlist_event.dart';

class WishListCardItemWidget extends StatelessWidget {
  const WishListCardItemWidget({super.key,required this.groceryItem, required this.wishBloc});

  final GroceryItem groceryItem;
  final WishlistBloc wishBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black,width: 1),
      ),
      child: Column(
        children: [
          Image(image: NetworkImage(groceryItem.url),
            width: double.infinity,
            fit: BoxFit.fitWidth,
            height: 300,
          ),
          Row(
            children: [
              Text('Name : ${groceryItem.title}'),
              SizedBox(width: 5),
              Text('Category : ${groceryItem.category}'),
            ],
          ),
          Row(
            children: [
              Text('Quantity : ${groceryItem.quantity}'),
              SizedBox(width: 5),
              Text('Units : ${groceryItem.units}')
            ],
          ),
          Row(
            children: [
              Text('Price : 20'),
              SizedBox(width: 5),
              IconButton(onPressed: (){
                wishBloc.add(RemoveFromWishlistEvent(groceryItem));
              }, icon: const Icon(Icons.favorite))
            ],
          )

        ],
      ),
    );
  }
}
