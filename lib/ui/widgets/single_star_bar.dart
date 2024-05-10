import 'package:flutter/material.dart';

import '../../utils/star_clipper.dart';

class SingleStar extends StatelessWidget {
  const SingleStar({super.key, required this.fillAmount});

  final double fillAmount;

  @override
  Widget build(BuildContext context) {
   const double starSize = 40;
    return SizedBox(
      height: starSize,
      width: starSize,
      child: Stack(
        fit: StackFit.loose,
        children: [
           const Icon(Icons.star,color: Colors.blue,size: starSize),
          ClipRect(
            clipper: StarClipper(
                part: fillAmount
            ),
            child:  const Icon(Icons.star,color: Colors.grey,size: starSize),
          )
        ],
      ),
    );;
  }
}