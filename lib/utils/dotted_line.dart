import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DottedLine extends CustomPainter{
  final double dotWidth;
  final double spacing;
  final double offsetXInitial;
  final double offsetYInitial;
  final double offsetXEnd;
  final double offsetYEnd;
  final Color color;

  DottedLine(
      {required this.color,
      required this.dotWidth,
      required this.spacing,
      this.offsetXInitial = 0,
      this.offsetYInitial = 0,
      this.offsetXEnd = 0,
      this.offsetYEnd = 0});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
        ..color = color
        ..strokeWidth = dotWidth
        ..style = PaintingStyle.stroke;

    double offsetX = offsetXInitial;
    double offsetY = offsetYInitial;

    if(offsetY < offsetYEnd && offsetX < offsetXEnd) { // left to right diagonal line
      while (offsetY < offsetYEnd) {
        canvas.drawLine(
          Offset(offsetX, offsetY),
          Offset(offsetX + dotWidth, offsetY + dotWidth),
          paint,
        );
        offsetX += spacing;
        offsetY += spacing;
      }
    } else if(offsetX > offsetXEnd){ //right to left diagonal line

      while (offsetX > offsetXEnd) {
        canvas.drawLine(
          Offset(offsetX, offsetY),
          Offset(offsetX - dotWidth, offsetY + dotWidth),
          paint,
        );
        offsetX -= spacing;
        offsetY += spacing;
      }
    } else { // straight line vertical
      while (offsetY < offsetYEnd) {
        canvas.drawLine(
          Offset(offsetX, offsetY),
          Offset(offsetX, offsetY + dotWidth),
          paint,
        );
        offsetY += spacing;
      }
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return false;
  }


}