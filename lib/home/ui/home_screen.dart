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
  double boxIntervalSpaces = 70;
  double strokeWidth = 10;
  double hexagonWidth = 80;
  double hexagonHeight = 100;
  double initialHorizontalPadding = 10;
  double initialVerticalPadding = 10;

  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  Widget drawHexagonTreeWidget(List<WidgetModel> list){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[0].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[0].key]!.last,
                textData: list[0].Title,
                boxWidth: hexagonWidth,homeBloc: homeBloc,details: list[0].details,boxHeight: hexagonHeight),
            SizedBox(width: boxIntervalSpaces),
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[1].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[1].key]!.last,
                textData: list[1].Title,
                boxWidth: hexagonWidth,
                homeBloc: homeBloc,details: list[1].details,
                boxHeight: hexagonHeight),
            SizedBox(width: boxIntervalSpaces),
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[2].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[2].key]!.last,
                textData: list[2].Title,
                boxWidth: hexagonWidth,
                homeBloc: homeBloc,details: list[1].details,
                boxHeight: hexagonHeight)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[3].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[3].key]!.last,
                textData: list[3].Title,
                boxWidth: hexagonWidth,
                homeBloc: homeBloc,details: list[1].details,
                boxHeight: hexagonHeight),
            SizedBox(width: boxIntervalSpaces),
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[4].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[4].key]!.last,
                textData: list[4].Title,
                boxWidth: hexagonWidth,
                homeBloc: homeBloc,details:list[4].details,
                boxHeight: hexagonHeight),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[5].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[5].key]!.last,
                textData: list[5].Title,
                boxWidth: hexagonWidth,
                homeBloc: homeBloc,details:list[5].details,
                boxHeight: hexagonHeight),
            SizedBox(width: boxIntervalSpaces),
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[6].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[6].key]!.last,
                textData: list[6].Title,
                boxWidth: hexagonWidth,
                homeBloc: homeBloc,details:list[5].details,
                boxHeight: hexagonHeight),
          ],
        ),
      ],
    );
  }

  Widget drawConnectionDottedLine(double offsetXInitial,double offsetYInitial,double offsetXEnd,double offsetYEnd,Color color){
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

    final l1XStarter  = hexagonWidth + initialHorizontalPadding;
    final l1YStarter  = (3/5 * hexagonHeight + initialVerticalPadding);
    final l1XFooter  = (hexagonWidth + hexagonWidth / 2);
    final l1YFooter  = (hexagonHeight + initialVerticalPadding);
    final l2XStarter = l1XStarter + boxIntervalSpaces + initialHorizontalPadding;
    final l2XFooter =  l1XStarter + hexagonWidth/2 ;
    final l3XStarter = l1XStarter + boxIntervalSpaces + hexagonWidth;
    final l3XFooter =  l3XStarter + hexagonWidth/2;
    final l4XStarter = 2*(l1XStarter +boxIntervalSpaces );
    final l5YStarter =  2*hexagonHeight - initialVerticalPadding;
    final l5YFooter =   l1YFooter + hexagonHeight ;

    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
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
                          drawHexagonTreeWidget(succState.widgetModelList),
                          drawConnectionDottedLine(
                              l1XStarter,
                              l1YStarter,
                              l1XFooter,
                              l1YFooter,
                              const Color.fromARGB(245, 243, 131, 6)),
                          drawConnectionDottedLine(
                              l2XStarter,
                              l1YStarter,
                              l2XFooter,
                              l1YFooter,
                              const Color.fromARGB(245, 9, 17, 143)),
                          drawConnectionDottedLine(
                              l3XStarter,
                              l1YStarter,
                              l3XFooter,
                              l1YFooter,
                              const Color.fromARGB(245, 9, 17, 143)),
                          drawConnectionDottedLine(
                              l4XStarter,
                              l1YStarter,
                              l3XFooter,
                              l1YFooter,
                              const Color.fromARGB(245, 243, 131, 6)),
                          drawConnectionDottedLine(
                              l2XFooter,
                              l5YStarter,
                              l2XFooter,
                              l5YFooter,
                              const Color.fromARGB(245, 9, 17, 143)),
                          drawConnectionDottedLine(
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

