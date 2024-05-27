import 'package:flutter/material.dart';
class StickyLabel extends StatelessWidget {
  const StickyLabel({super.key, required this.strikePrice});
  final double strikePrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white54
      ),
      alignment: Alignment.center,
      //  duration: const Duration(seconds: 1),
      child: Text( '$strikePrice',
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
