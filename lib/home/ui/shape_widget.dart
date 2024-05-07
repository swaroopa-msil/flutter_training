import 'package:flutter/material.dart';
import 'package:march09/home/bloc/home_bloc.dart';

import '../../utils/hexagon_painter.dart';
import '../bloc/home_event.dart';

class HexagonShapeWidget extends StatelessWidget {
  const HexagonShapeWidget({super.key,required this.boxWidth,required this.borderColor1,required this.borderColor2,
    required this.textData , required this.homeBloc, required this.details
  });

  final Color borderColor1;
  final Color borderColor2;
  final String textData;
  final double boxWidth;
  final HomeBloc homeBloc;
  final String details;

  @override
  Widget build(BuildContext context) {
    return
     GestureDetector(
       onTap: (){
         homeBloc.add(WidgetClickNavigationEvent(detailsData: details));
       },
       child: Stack(
          alignment: Alignment.center,
          children: [
           SizedBox(
             width: boxWidth+10,
             child: CustomPaint(
                  painter: HexagonPainter(borderColor1: const Color.fromARGB(
                      121, 203, 195, 195),borderColor2: const Color.fromARGB(
                      121, 203, 195, 195),strokeSize: 10),
                ),
           ),
            SizedBox(
              width: boxWidth,
              height: 100,
                child: CustomPaint(
                  painter: HexagonPainter(borderColor1: borderColor1,borderColor2: borderColor2,strokeSize: 8),
                ),

            ),
            Text(textData,style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold))
          ],
       ),
     );
  }
}
