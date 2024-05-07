import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march09/home/bloc/home_bloc.dart';
import 'package:march09/home/ui/shape_widget.dart';
import 'package:march09/utils/dotted_line.dart';
import 'package:march09/utils/fade_in_animation.dart';

import '../../data/data_details.dart';
import '../../details/ui/details_screen.dart';
import '../../model/widget_model.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double _boxIntervalSpaces = 70;
  final double _hexagonWidth = 80;
  final double _hexagonHeight = 100;
  final double _initialHorizontalPadding = 10;
  final double _initialVerticalPadding = 10;

  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  List<Widget> _getRowWidgets(int noRows, List<WidgetModel> list,int startingIndex) {
    List<Widget> widgetList = [];
    final int len = startingIndex + noRows;
    for (int i = startingIndex; i < len; i++) {
      widgetList.add(HexagonShapeWidget(
          borderColor: WidgetDetails.colorMap[list[i].key]!,
          boxWidth: _hexagonWidth,
          homeBloc: _homeBloc,
          model: list[i],
          boxHeight: _hexagonHeight));
      if(i < len-1){
        widgetList.add(SizedBox(width: _boxIntervalSpaces));
      }
    }
    return widgetList;
  }

  Widget _drawHexagonTreeWidget(List<WidgetModel> list){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _getRowWidgets(3,list,0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _getRowWidgets(2,list,3)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _getRowWidgets(2,list,5)
        ),
      ],
    );
  }

  Widget _rawConnectionDottedLine(double offsetXInitial,double offsetYInitial,double offsetXEnd,double offsetYEnd,Color color){
    return    CustomPaint(
      painter: DottedLine(
          offsetXInitial: offsetXInitial,
          offsetYInitial: offsetYInitial,
          offsetXEnd: offsetXEnd,
          offsetYEnd: offsetYEnd,
          color: color,
          spacing: 5,
          dotWidth: 2),
    );
  }

  @override
  Widget build(BuildContext context) {

    final l1XStarter  = _hexagonWidth + _initialHorizontalPadding;
    final l1YStarter  = (3/5 * _hexagonHeight + _initialVerticalPadding);
    final l1XFooter  = (_hexagonWidth + _hexagonWidth / 2);
    final l1YFooter  = (_hexagonHeight + _initialVerticalPadding);
    final l2XStarter = l1XStarter + _boxIntervalSpaces + _initialHorizontalPadding;
    final l2XFooter =  l1XStarter + _hexagonWidth/2 ;
    final l3XStarter = l1XStarter + _boxIntervalSpaces + _hexagonWidth;
    final l3XFooter =  l3XStarter + _hexagonWidth/2;
    final l4XStarter = 2*(l1XStarter +_boxIntervalSpaces );
    final l5YStarter =  2*_hexagonHeight - _initialVerticalPadding;
    final l5YFooter =   l1YFooter + _hexagonHeight ;

    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listenWhen: (previous,current) => current is HomeActionState,
      buildWhen: (previous,current) => current is !HomeActionState,
  listener: (context, state) {
    if(state is HomeToWidgetDetailState){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return  DetailsScreen(description: state.description);
      }));
    }
  },
  builder: (context, state) {
        switch(state.runtimeType){
          case HomeSuccessLoadingState:
            final succState = state as HomeSuccessLoadingState;
            return Scaffold(
              body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: FadeInAnimation(
                      parentChild: Stack(
                        children: [
                          _drawHexagonTreeWidget(succState.widgetModelList),
                          _rawConnectionDottedLine(
                              l1XStarter,
                              l1YStarter,
                              l1XFooter,
                              l1YFooter,
                              const Color.fromARGB(245, 243, 131, 6)),
                          _rawConnectionDottedLine(
                              l2XStarter,
                              l1YStarter,
                              l2XFooter,
                              l1YFooter,
                              const Color.fromARGB(245, 9, 17, 143)),
                          _rawConnectionDottedLine(
                              l3XStarter,
                              l1YStarter,
                              l3XFooter,
                              l1YFooter,
                              const Color.fromARGB(245, 9, 17, 143)),
                          _rawConnectionDottedLine(
                              l4XStarter,
                              l1YStarter,
                              l3XFooter,
                              l1YFooter,
                              const Color.fromARGB(245, 243, 131, 6)),
                          _rawConnectionDottedLine(
                              l2XFooter,
                              l5YStarter,
                              l2XFooter,
                              l5YFooter,
                              const Color.fromARGB(245, 9, 17, 143)),
                          _rawConnectionDottedLine(
                              l3XFooter,
                              l5YStarter,
                              l3XFooter,
                              l5YFooter,
                              const Color.fromARGB(245, 9, 17, 143)),
                        ],
                      ),
                    )),
              ),
            );
          default: return const SizedBox();
        }
  },
);
  }
}

