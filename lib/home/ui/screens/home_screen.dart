import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march09/home/bloc/home_bloc.dart';
import 'package:march09/home/ui/screens/watchlist_screen.dart';
import 'package:march09/home/utils/app_constants.dart';

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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabControl = TabController(length: HomeBloc.totalTabs, vsync: this);
    _homeBloc.add(InitialDataLoadingEvent());
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  /// Watchlist tab screen display
  List<Widget> tabViewCall(HomeState state){
    final List<Widget> list = [];
    switch(state.runtimeType){
      case const (HomeLoading) :
        list.add(const Center(
          child: CircularProgressIndicator(),
        ));
        break;
      case const (HomeLoadingSuccess):
      {
        final successState = state as HomeLoadingSuccess;
        if(successState.contactList.isEmpty){
          list.add(
            const Center(
              child: Text(AppConstant.NO_DATA_AVAILABLE_MESSAGE),
            )
          );
        }else{
          list.add(WatchlistScreen(contactList: successState.contactList, scrollController: _scrollController));
          _scrollToTop();
        }
      }break;
      case const (HomeLoadingError):
        final errorState = state as HomeLoadingError;
        list.add( Center(
          child: Text(errorState.errorMessage),
        ));
        break;
      default: list.add(const SizedBox());
    }
    return list;
  }

  /// Sorting Bottom sheet
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
       if(state is NavigateToSortingDialog){
         _openSortingBottomSheet(context);
       }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title:  const Text(AppConstant.TITLE_CONTACT_LOG),
            bottom: TabBar(
              controller: _tabControl,
              labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              tabs: [
                for(int i = 0; i < HomeBloc.totalTabs; i++)
                  Tab(text: '${AppConstant.CONTACT_TAB_LABEL} ${i + 1}')
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
