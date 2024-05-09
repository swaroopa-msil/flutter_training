import 'package:flutter/material.dart';

import '../../utils/star_clipper.dart';

class SingleStar extends StatelessWidget {
  const SingleStar({super.key, required this.pos, required this.fillAmount});

  final int pos;
  final double fillAmount;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 40,
      width: 40,
      child: Stack(
        fit: StackFit.loose,
        children: [
          const Icon(Icons.star,color: Colors.blue,size: 40),
          ClipRect(
            clipper: StarClipper(
                part: fillAmount
            ),
            child: const Icon(Icons.star,color: Colors.grey,size: 40),
          )
        ],
      ),
    );;
  }
}