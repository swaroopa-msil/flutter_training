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
  double outerBoxWidthSide = 80;
  double boxHeightSide = 100;
  double initialPaddingHorizontal = 20;
  double initialPaddingVertical = 20;

  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  // Widget getRow(int count,List<WidgetModel> list){
  //   Widget w = Text(data);
  //   for(int i=0;i<3;i++){
  //     w = HexagonShapeWidget(
  //         borderColor1: WidgetDetails.colorMap[list[i].key]!.first,
  //         borderColor2:WidgetDetails.colorMap[list[i].key]!.last,
  //         textData: list[i].Title,
  //         boxWidth: boxIntervalSpaces,homeBloc: homeBloc,details: list[i].details);
  //   SizedBox(width: boxIntervalSpaces);
  //   }
  //   return w;
  // }

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
                borderColor1:
                const Color.fromARGB(245, 81, 127, 245),
                borderColor2:
                const Color.fromARGB(245, 9, 17, 143),
                boxWidth: boxIntervalSpaces,
                textData: 'Animation\nController',
                homeBloc: homeBloc,details: 'Details of  animation Controller'),
            SizedBox(width: boxIntervalSpaces),
            HexagonShapeWidget(
                borderColor1:
                const Color.fromARGB(255, 234, 207, 37),
                borderColor2:
                const Color.fromARGB(245, 243, 131, 6),
                boxWidth: boxIntervalSpaces,
                textData: 'Tween(s)',
                homeBloc: homeBloc,details: 'Details of  Tween')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HexagonShapeWidget(
                borderColor1:
                const Color.fromARGB(245, 81, 127, 245),
                borderColor2:
                const Color.fromARGB(245, 9, 17, 143),
                textData: 'Animation',
                boxWidth: boxIntervalSpaces,
                homeBloc: homeBloc,details: 'Details of  Animation'),
            SizedBox(width: boxIntervalSpaces),
            HexagonShapeWidget(
                borderColor1:
                const Color.fromARGB(245, 81, 127, 245),
                borderColor2:
                const Color.fromARGB(245, 9, 17, 143),
                boxWidth: boxIntervalSpaces,
                textData: 'Animation',
                homeBloc: homeBloc,details: 'Details of  Animation'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HexagonShapeWidget(
                borderColor1:
                const Color.fromARGB(245, 243, 9, 224),
                borderColor2:
                const Color.fromARGB(245, 138, 7, 189),
                boxWidth: boxIntervalSpaces,
                textData: 'Widget',
                homeBloc: homeBloc,details: 'Details of  Widget'),
            SizedBox(width: boxIntervalSpaces),
            HexagonShapeWidget(
                borderColor1:
                const Color.fromARGB(245, 243, 9, 224),
                borderColor2:
                const Color.fromARGB(245, 138, 7, 189),
                boxWidth: boxIntervalSpaces,
                textData: 'Widget',
                homeBloc: homeBloc,details: 'Details of  Widget'),
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
        return const DetailsScreen();
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
                          drawConnectionDottedLine(boxIntervalSpaces + initialPaddingHorizontal,boxIntervalSpaces,2 * boxIntervalSpaces,boxHeightSide + strokeWidth,const Color.fromARGB(245, 243, 131, 6)),
                          drawConnectionDottedLine(boxHeightSide + boxIntervalSpaces,boxIntervalSpaces,boxIntervalSpaces +
                              (outerBoxWidthSide - initialPaddingHorizontal),boxHeightSide + strokeWidth,const Color.fromARGB(245, 9, 17, 143)),
                          drawConnectionDottedLine((outerBoxWidthSide - initialPaddingHorizontal) * 4,boxIntervalSpaces,boxHeightSide + (5 * boxIntervalSpaces) / 2,boxHeightSide + strokeWidth,
                              const Color.fromARGB(245, 9, 17, 143)),
                          drawConnectionDottedLine(outerBoxWidthSide * 4,boxIntervalSpaces,4 * boxIntervalSpaces,boxHeightSide + strokeWidth,const Color.fromARGB(245, 243, 131, 6)),
                          drawConnectionDottedLine(boxIntervalSpaces +
                              (outerBoxWidthSide - initialPaddingHorizontal), boxHeightSide +
                              boxIntervalSpaces +
                              initialPaddingVertical,boxIntervalSpaces +
                              (outerBoxWidthSide - initialPaddingHorizontal),(2 * boxHeightSide) + (initialPaddingVertical / 2),const Color.fromARGB(245, 9, 17, 143)),
                          drawConnectionDottedLine( 4 * boxIntervalSpaces,boxHeightSide +
                              boxIntervalSpaces +
                              initialPaddingVertical, 4 * boxIntervalSpaces,(2 * boxHeightSide) + (initialPaddingVertical / 2),const Color.fromARGB(245, 9, 17, 143)),
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

