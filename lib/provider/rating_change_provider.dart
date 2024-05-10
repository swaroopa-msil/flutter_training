import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../ui/widgets/single_star_bar.dart';

class RatingChangeProvider extends ChangeNotifier {
  double rating = 0;
  final List<Widget> _startWidgetList = [];
  final List<AnimationController> _controllersList = [];
  final List<Animation<num>> _animationList = [];


  void updateRating(double rate) {
    rating = rate;
    notifyListeners();
  }

  Widget getStarWidget(int index){
    return _startWidgetList[index];
  }

  Animation getStarAnimation(int index){
    return _animationList[index];
  }

  double getAnimationValue(int index){
    return _animationList[index].value.toDouble();
  }

  AnimationController getStarController(int index){
    return _controllersList[index];
  }

  void updateAnimationList(int index, double endProgress){
    var colorAnimation = Tween(
      begin: 0.0,
      end: endProgress,
    ).animate(_controllersList[index]);
    _animationList.add(colorAnimation);
  }

  void updateWidgetList(int index){
    var singleStar = SingleStar(fillAmount: _controllersList[index].value);
    _startWidgetList.add(singleStar);
  }
  void updateControllerList(AnimationController controller){
    _controllersList.add(controller);
  }


  }
