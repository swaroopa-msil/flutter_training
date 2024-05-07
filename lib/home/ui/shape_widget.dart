import 'package:flutter/material.dart';

import '../../utils/hexagon_painter.dart';

class HexagonShapeWidget extends StatelessWidget {
  const HexagonShapeWidget({super.key, required this.borderColor1,required this.borderColor2, required this.textData
  });

  final Color borderColor1;
  final Color borderColor2;
  final String textData;

  @override
  Widget build(BuildContext context) {
    return
     Stack(
        alignment: Alignment.center,
        children: [
         SizedBox(
           width: 80,
           child: CustomPaint(
                painter: HexagonPainter(borderColor1: const Color.fromARGB(
                    121, 203, 195, 195),borderColor2: const Color.fromARGB(
                    121, 203, 195, 195),strokeSize: 10),
              ),
         ),
          SizedBox(
            width: 70,
            height: 100,
              child: CustomPaint(
                painter: HexagonPainter(borderColor1: borderColor1,borderColor2: borderColor2,strokeSize: 8),
              ),

          ),
          Text(textData,style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold))
        ],
     );
  }
}
