import 'package:flutter/material.dart';

class CategoryModel{
  const CategoryModel({required this.id, this.color = Colors.orange,required this.title});
  final String id;
  final String title;
  final Color color;
}