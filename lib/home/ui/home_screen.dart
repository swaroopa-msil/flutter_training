import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:march09/home/provider/widget_data_provider.dart';
import 'package:march09/home/ui/shape_widget.dart';
import 'package:march09/utils/dotted_line.dart';
import 'package:march09/utils/fade_in_animation.dart';
import 'package:provider/provider.dart';

import '../../data/data_details.dart';
import '../../model/widget_model.dart';

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

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _getRowWidgets(
      int noRows, List<WidgetModel> list, int startingIndex) {
    List<Widget> widgetList = [];
    final int len = startingIndex + noRows;
    for (int i = startingIndex; i < len; i++) {
      widgetList.add(HexagonShapeWidget(
          borderColor: WidgetDetails.colorMap[list[i].key]!,
          boxWidth: _hexagonWidth,
          model: list[i],
          boxHeight: _hexagonHeight));
      if (i < len - 1) {
        widgetList.add(SizedBox(width: _boxIntervalSpaces));
      }
    }
    return widgetList;
  }

  Widget _drawHexagonTreeWidget(List<WidgetModel> list) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _getRowWidgets(3, list, 0),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _getRowWidgets(2, list, 3)),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _getRowWidgets(2, list, 5)),
      ],
    );
  }

  Widget _rawConnectionDottedLine(double offsetXInitial, double offsetYInitial,
      double offsetXEnd, double offsetYEnd, Color color) {
    return CustomPaint(
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
    final provider = context.watch<WidgetDataProvider>();

    final l1XStarter  = _hexagonWidth + _initialHorizontalPadding;
    final l1YStarter  = (3/5 * _hexagonHeight + _initialVerticalPadding);
    final l1XFooter  = l1XStarter + _hexagonWidth / 2;
    final l1YFooter  = (_hexagonHeight + _initialVerticalPadding);
    final l2XStarter = l1XStarter + _boxIntervalSpaces + _initialHorizontalPadding;
    final l3XStarter = l2XStarter  + (_hexagonWidth - _initialHorizontalPadding);
    final l3XFooter =  l3XStarter + _hexagonWidth/2;
    final l4XStarter = l3XStarter + _boxIntervalSpaces + _initialHorizontalPadding;
    final l5YStarter =  2*_hexagonHeight - _initialVerticalPadding;
    final l5YFooter =   l5YStarter +  2*_initialVerticalPadding;
    provider.getWidgetList();
            return Scaffold(
              body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: FadeInAnimation(
                      parentChild: Stack(
                        children: [
                          _drawHexagonTreeWidget(provider.widgetModelList),
                          _rawConnectionDottedLine(
                              l1XStarter,
                              l1YStarter,
                              l1XFooter,
                              l1YFooter,
                              const Color.fromARGB(245, 243, 131, 6)),
                          _rawConnectionDottedLine(
                              l2XStarter,
                              l1YStarter,
                              l1XFooter,
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
                              l1XFooter,
                              l5YStarter,
                              l1XFooter,
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
  }
}

