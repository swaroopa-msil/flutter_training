import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march09/home/bloc/home_bloc.dart';
import 'package:march09/home/ui/screens/watchlist_screen.dart';

import '../widget/sorting_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  final HomeBloc _homeBloc = HomeBloc();

  late TabController _tabControl;
  int tabCount = 5;

  @override
  void initState() {
    super.initState();
    _tabControl = TabController(length: 5, vsync: this);
    _homeBloc.add(InitialDataLoadingEvent());
  }

  List<Widget> tabViewCall(HomeState state){
    final List<Widget> list = [];
    switch(state.runtimeType){
      case HomeLoading :
        list.add(const Center(
          child: CircularProgressIndicator(),
        ));
      case HomeLoadingSuccess:
        final successState = state as HomeLoadingSuccess;
        list.add(WatchlistScreen(contactList: successState.contactList));
      case HomeLoadingError:
        list.add(const Center(
          child: Text('error'),
        ));
      default: list.add(const SizedBox());
    }
    return list;
  }

  void _openSortingBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: 200,
        padding: const EdgeInsets.all(15),
        child: Center(
            child: SortingWidget(homeBloc: _homeBloc)
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listenWhen: (prev,curr) => curr is HomeActionState,
      buildWhen: (prev,curr) => curr is !HomeActionState,
      listener: (context, state) {
       if(state is SortDialogLoadingSuccess){
         _openSortingBottomSheet(context);
       }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabControl,
              labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              tabs: [
                for(int i = 0; i < tabCount; i++)
                  Tab(text: 'Contact ${i + 1}')
              ],
              onTap: (index){
                _homeBloc.add(ContactTabClickedEvent(tabIndex: index));
              },
            ),
          ),
          body: TabBarView(
            controller: _tabControl,
            children: tabViewCall(state),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.sort),
            onPressed: () {
              _homeBloc.add(FloatingSortButtonClickedEvent());
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabControl.dispose();
    super.dispose();
  }
}
