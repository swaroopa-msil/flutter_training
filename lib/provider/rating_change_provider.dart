
import 'package:flutter/foundation.dart';

class RatingChangeProvider extends ChangeNotifier{
  double rating = 0;


  void updateRating(double rate){
    rating = rate;
    notifyListeners();
  }

}