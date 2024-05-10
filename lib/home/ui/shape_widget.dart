import 'package:flutter/material.dart';
import 'package:march09/model/widget_model.dart';

import '../../details/ui/details_screen.dart';
import '../../utils/hexagon_painter.dart';

class HexagonShapeWidget extends StatelessWidget {
  const HexagonShapeWidget({super.key,required this.boxWidth,required this.borderColor,
    required this.model , required this.boxHeight
  });

  final List<Color> borderColor;
  final WidgetModel model;
  final double boxWidth;
  final double boxHeight;

  void navigateTo(String description,BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return  DetailsScreen(description: description);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return
     GestureDetector(
       onTap: (){
         navigateTo(model.details,context);
       },
       child: Stack(
          alignment: Alignment.center,
          children: [
           SizedBox(
             width: boxWidth,
             child: CustomPaint(
                  painter: HexagonPainter(borderColor1: const Color.fromARGB(
                      121, 203, 195, 195),borderColor2: const Color.fromARGB(
                      121, 203, 195, 195),strokeSize: 10),
                ),
           ),
            SizedBox(
              width: boxWidth-10,
              height: boxHeight,
                child: CustomPaint(
                  painter: HexagonPainter(borderColor1: borderColor[0],borderColor2: borderColor[1],strokeSize: 8),
                ),

            ),
            Text(model.Title,style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold))
          ],
       ),
     );
  }
}
