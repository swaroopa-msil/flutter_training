import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march09/home/bloc/home_bloc.dart';
import 'package:march09/model/grocery_item.dart';
import 'package:march09/wishlist/bloc/wishlist_bloc.dart';

import '../wishlist/bloc/wishlist_event.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({super.key,required this.groceryItem, required this.bloc});

  final GroceryItem groceryItem;
  final Bloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
              const SizedBox(width: 5),
              Text('Category : ${groceryItem.category}'),
            ],
          ),
          Row(
            children: [
              Text('Quantity : ${groceryItem.quantity}'),
              const SizedBox(width: 5),
              Text('Units : ${groceryItem.units}')
            ],
          ),
          Row(
            children: [
               Text('Price : ${groceryItem.price}'),
              const SizedBox(width: 5),
              IconButton(onPressed: (){
                if(bloc is HomeBloc){
                  bloc.add(ItemWishListIconClickEvent(groceryItem: groceryItem));
                }else if(bloc is WishlistBloc){
                  bloc.add(RemoveFromWishlistEvent(groceryItem));
                }
              }, icon: Icon(Icons.favorite,color: groceryItem.isWishListed ? Colors.red : Colors.grey,))
            ],
          )

        ],
      ),
    );
  }
}
