
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RatingChangeProvider extends ChangeNotifier {
  double rating = 0;


  void updateRating(double rate) {
    rating = rate;
    notifyListeners();
  }

}