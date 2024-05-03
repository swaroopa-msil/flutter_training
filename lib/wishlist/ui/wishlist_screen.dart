import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march09/home/ui/home_screen.dart';
import 'package:march09/utils.dart';
import 'package:march09/widgets/card_item_widget.dart';
import 'package:march09/wishlist/bloc/wishlist_bloc.dart';

import '../bloc/wishlist_event.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

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

  void listenWishlistAction(WishlistState state) {
    if (state is WishListToHomeNavSuccessState) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }));
    }
  }

  Widget wishlistLoadSuccessUI(WishlistState state){
    final successState = state as WishlistLoadSuccessState;
    return ListView.builder(
        itemCount: successState.groceryItemList.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CardItemWidget(groceryItem:successState.groceryItemList[index],bloc: wishlistBloc),
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
        actions: [
          IconButton(onPressed: (){
            wishlistBloc.add(WishListNavToHomeSuccessEvent());
          }, icon: const Icon(Icons.home))
        ],
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        buildWhen: (prev,current) => current is !WishlistActionState,
        listenWhen: (prev,current) => current is WishlistActionState,
        bloc: wishlistBloc,
        listener: (context, state) {
          listenWishlistAction(state);
        },
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
