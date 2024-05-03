import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march09/home/bloc/home_bloc.dart';

import '../../utils.dart';
import '../../widgets/card_item_widget.dart';
import '../../wishlist/ui/wishlist_screen.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  void listenHomeAction(HomeState state){
    if(state is HomeToWishListNavigateState){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return const WishListScreen();
      }));
    }else if(state is AddedOrRemovedWishListItemActionState){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  Widget getHomeSuccessUI(HomeState state){
    final successState = state as HomeLoadingSuccessState;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:  Text(AppConstants.WatchListLabel),
        actions: [
          IconButton(onPressed: (){
            homeBloc.add(WishListBarClickEvent());
          }, icon: const Icon(Icons.favorite))
        ],
      ),
      body: ListView.builder(
          itemCount: successState.groceryItem.length,
          itemBuilder: (context,index){
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardItemWidget(groceryItem: successState.groceryItem[index],bloc: homeBloc,)
            );
          }),
    );
  }


  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous,current) => current is HomeActionState,
      buildWhen: (previous,current) => current is !HomeActionState,
  listener: (context, state) {
    listenHomeAction(state);
  },
  builder: (context, state) {
        switch(state.runtimeType){
          case HomeLoadingState :
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadingSuccessState: return getHomeSuccessUI(state);
          case HomeErrorState:
            final error = state as HomeErrorState;
            return Scaffold(
              body: Center(
                child: Text(error.errorMessage),
              ),
            );
          default : return const SizedBox();
        }
  },
);
  }
}
