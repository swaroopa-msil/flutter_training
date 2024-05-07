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
  double initialHorizPad = 20;
  double verticalPadding = 20;

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
                boxWidth: boxIntervalSpaces,homeBloc: homeBloc,details: list[0].details),
            SizedBox(width: boxIntervalSpaces),
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[1].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[1].key]!.last,
                textData: list[1].Title,
                boxWidth: boxIntervalSpaces,
                homeBloc: homeBloc,details: list[1].details),
            SizedBox(width: boxIntervalSpaces),
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[2].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[2].key]!.last,
                textData: list[2].Title,
                boxWidth: boxIntervalSpaces,
                homeBloc: homeBloc,details: list[1].details)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[3].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[3].key]!.last,
                textData: list[3].Title,
                boxWidth: boxIntervalSpaces,
                homeBloc: homeBloc,details: list[1].details),
            SizedBox(width: boxIntervalSpaces),
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[4].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[4].key]!.last,
                textData: list[4].Title,
                boxWidth: boxIntervalSpaces,
                homeBloc: homeBloc,details:list[4].details),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[5].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[5].key]!.last,
                textData: list[5].Title,
                boxWidth: boxIntervalSpaces,
                homeBloc: homeBloc,details:list[5].details),
            SizedBox(width: boxIntervalSpaces),
            HexagonShapeWidget(
                borderColor1: WidgetDetails.colorMap[list[6].key]!.first,
                borderColor2:WidgetDetails.colorMap[list[6].key]!.last,
                textData: list[6].Title,
                boxWidth: boxIntervalSpaces,
                homeBloc: homeBloc,details:list[5].details),
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
                              hexagonWidth + initialHorizPad / 2,
                              (3/5 * hexagonHeight + verticalPadding / 2),
                              (hexagonWidth + hexagonWidth / 2),
                              (hexagonHeight + verticalPadding / 2),
                              const Color.fromARGB(245, 243, 131, 6)),
                          drawConnectionDottedLine(
                              hexagonWidth + boxIntervalSpaces + initialHorizPad,
                              (3/5 * hexagonHeight +verticalPadding / 2 ),
                              hexagonWidth + hexagonWidth/2 + initialHorizPad/2,
                              (hexagonHeight + verticalPadding / 2),
                              const Color.fromARGB(245, 9, 17, 143)),
                          drawConnectionDottedLine(
                              hexagonWidth*2 + boxIntervalSpaces + initialHorizPad/2,
                              (3/5 * hexagonHeight +verticalPadding / 2 ),
                              hexagonWidth*2 + boxIntervalSpaces + initialHorizPad/2 + hexagonWidth/2,
                              (hexagonHeight + verticalPadding / 2),
                              const Color.fromARGB(245, 9, 17, 143)),
                          drawConnectionDottedLine(
                              2*hexagonWidth + 2*boxIntervalSpaces + initialHorizPad,
                              (3/5 * hexagonHeight +verticalPadding / 2 ),
                              hexagonWidth*2 + boxIntervalSpaces + initialHorizPad/2 + hexagonWidth/2,
                              (hexagonHeight + verticalPadding / 2),
                              const Color.fromARGB(245, 243, 131, 6)),
                          drawConnectionDottedLine(
                              hexagonWidth + hexagonWidth/2 + initialHorizPad/2,
                              2*hexagonHeight - (verticalPadding / 2),
                              hexagonWidth + hexagonWidth/2 + initialHorizPad/2,
                              (2 * hexagonHeight) + (verticalPadding / 2),
                              const Color.fromARGB(245, 9, 17, 143)),
                          drawConnectionDottedLine(
                              hexagonWidth*2 + boxIntervalSpaces + initialHorizPad/2 + hexagonWidth/2,
                              2*hexagonHeight - (verticalPadding / 2),
                              hexagonWidth*2 + boxIntervalSpaces + initialHorizPad/2 + hexagonWidth/2,
                              (2 * hexagonHeight) + (verticalPadding / 2),
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

