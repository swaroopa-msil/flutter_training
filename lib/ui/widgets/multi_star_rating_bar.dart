import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:march09/ui/widgets/single_star_bar.dart';



class MultiStarRatingBar extends StatefulWidget {
  const MultiStarRatingBar({super.key, required this.rating});

  final double rating ;

  @override
  State<MultiStarRatingBar> createState() => _MultiStarRatingBarState();
}

class _MultiStarRatingBarState extends State<MultiStarRatingBar> with TickerProviderStateMixin {
  final int _starCount = 5;
  final Duration _duration = const Duration(seconds: 1);
  final List<Widget> _startWidgetList = [];
  final List<AnimationController> _controllersList = [];
  final List<Animation<num>> _animationList = [];

  double _fullStar = 0;
  double _partialStar = 0;

  @override
  void initState() {
    super.initState();
    buildStarRow(widget.rating);
  }

  // for creating animation and controllers for each stars
  void buildStarRow(double currentRatings){

    _fullStar = currentRatings.floor().toDouble();  // 3
    _partialStar = currentRatings - _fullStar;  // 0.6

    var end = 1.0;
    for(int i=0 ; i< _starCount ; i++){

      if(i >= _fullStar && end != 0){ // partial stars
          end = _partialStar;
      }

      var controller = AnimationController(
        vsync: this,
        duration: _duration,
      );
      _controllersList.add(controller);

      var colorAnimation = Tween(
        begin: 0.0,
        end:  end ,
      ).animate(controller);
      _animationList.add(colorAnimation);

      var singleStar = SingleStar(pos: i , fillAmount: controller.value);
      _startWidgetList.add(singleStar);

      if(end < 1.0){ // empty stars
        end = 0.0;
      }
    }
    controllerCall(0);
  }

// for starting next animation when current one finishes
  void controllerCall(int i){
    _controllersList[i].addListener(() {
      setState(() {
      });
    });

    _animationList[i].addListener(() {
      if(_animationList[i].isCompleted){
        if(i < (_starCount-1)){
          controllerCall(i+1);
        }
      }

      });
    _controllersList[i].forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(_animationList.length, (index) {
        return SingleStar(pos: 0 , fillAmount: _animationList[index].value.toDouble());
      })
    );
  }

  @override
  void dispose() {
    for(int i =0; i< _starCount ; i++ ){
      _controllersList[i].dispose();
    }
    super.dispose();
  }

}
