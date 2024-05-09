import 'package:flutter/material.dart';
import 'dart:math';

class HexagonPainter extends CustomPainter{
  final Color borderColor1;
  final Color borderColor2;
  final double strokeSize;
  HexagonPainter({
    required this.borderColor1,
    required this.borderColor2,
    required this.strokeSize
});



  @override
  void paint(Canvas canvas, Size size) {
    final Shader gradient = LinearGradient(
      colors: [borderColor1, borderColor2],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Paint paint = Paint()
      ..shader = gradient
      ..strokeWidth = strokeSize
      ..style = PaintingStyle.stroke;

     Path path = Path();

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2;
    double angle = (2 * pi) / 6;
    path.moveTo((centerX + radius * cos(angle * 0)),(centerY + radius * sin(angle * 0)));

    for (int i = 1; i < 6; i++) {
      double x = centerX + radius * cos(angle * i);
      double y = centerY + radius * sin(angle * i);

       path.lineTo(x, y);
        // path.quadraticBezierTo(centerX,size.height,
        //     size.width,centerY);

    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }


}


//    for (int i = 1; i < 6; i++) {
//     double x = centerX + (radius) * cos((angle) * i);
//     double y = centerY + (radius) * sin((angle) * i);
//
//       double curvX = centerX + (radius) * cos((angle) * i+1);
//       double curvY = centerY + (radius) * sin((angle) * i+1);
//
//       if(i==1){
//         path.lineTo(x, y+1);
//       }
//       else{
//         path.lineTo(x+1, y+1);
//       }
//     path.quadraticBezierTo(x+1,y+1,
//         curvX+1, curvY+1);
//     }