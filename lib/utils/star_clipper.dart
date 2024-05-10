import 'package:flutter/cupertino.dart';

class StarClipper extends CustomClipper<Rect>{

  final double part;
  StarClipper({required this.part});
  
  @override
  getClip(Size size) {
   return Rect.fromLTRB((size.width)*part,0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
   return true;
  }
  
}