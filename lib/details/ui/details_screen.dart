import 'package:flutter/material.dart';

import '../../utils/app_constants.dart';
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.WidgetDetailTitle),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Text(description, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.teal)),
        ),
    );
  }
}
