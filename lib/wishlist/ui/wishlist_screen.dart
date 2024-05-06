import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march09/utils.dart';
import 'package:march09/widgets/card_item_widget.dart';
import 'package:march09/wishlist/bloc/wishlist_bloc.dart';

import '../../home/bloc/home_bloc.dart';
import '../bloc/wishlist_event.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key, required this.homeBloc});
  final HomeBloc homeBloc;
  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

WishlistBloc wishlistBloc = WishlistBloc();


class _WishListScreenState extends State<WishListScreen> {

  @override
  void initState() {
    wishlistBloc.add(WishListLoadedSuccessEvent());
    super.initState();
  }

  Widget wishlistLoadSuccessUI(WishlistState state){
    final successState = state as WishlistLoadSuccessState;
    return ListView.builder(
        itemCount: successState.groceryItemList.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CardItemWidget(groceryItem:successState.groceryItemList[index],bloc: wishlistBloc,hBloc: widget.homeBloc),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(AppConstants.WishListLabel),
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        buildWhen: (prev,current) => current is !WishlistActionState,
        bloc: wishlistBloc,
        builder: (context, state) {
          switch(state.runtimeType){
            case WishlistLoadSuccessState:
              return wishlistLoadSuccessUI(state);
            default: const SizedBox();
          }
          return Container();
        },
      ),
    );
  }
}
