import 'package:flutter/material.dart';

import '../../utils/option_chain_utils.dart';

class SingleCell extends StatelessWidget {
  const SingleCell({super.key, required this.displayValue, required this.index, required this.header });
  final String displayValue;
  final int index;
  final Optionchain header;

  Color getTextColor(int column, Optionchain header) {
    if ((header == Optionchain.PUT && column == 0) ||
        (header == Optionchain.CALL && column == 1) ||
        (header == Optionchain.STRIKE)) {
      return Colors.white;
    }
    return const Color.fromARGB(200, 231, 127, 127);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          displayValue,
          style: TextStyle(color: getTextColor(index, header)),
        ),
      ),
    );
  }
}
