import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:march09/provider/rating_change_provider.dart';
import 'package:march09/ui/widgets/single_star_bar.dart';
import 'package:provider/provider.dart';

class MultiStarRatingBar extends StatefulWidget {
  const MultiStarRatingBar({super.key, required this.provider});

  final RatingChangeProvider provider;

  @override
  State<MultiStarRatingBar> createState() => _MultiStarRatingBarState();
}

class _MultiStarRatingBarState extends State<MultiStarRatingBar>
    with TickerProviderStateMixin {
  final int _starCount = 5;

  @override
  void initState() {
    super.initState();
    buildStarRow(widget.provider.rating);
  }

  // for creating animation and controllers for each stars
  void buildStarRow(double currentRatings) {

    double fullStar = currentRatings.floor().toDouble(); // 3
    double partialStar = currentRatings - fullStar; // 0.6

    var end = 1.0;
    for (int i = 0; i < _starCount; i++) {
      if (i >= fullStar && end != 0) {
        // partial stars
        end = partialStar;
      }

      widget.provider.updateControllerList(AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      ));
      widget.provider.updateAnimationList(i, end);
      widget.provider.updateWidgetList(i);

      if (end < 1.0) {// empty stars
        end = 0.0;
      }
    }
    controllerCall(0);
  }

// for starting next animation when current one finishes
  void controllerCall(int i ) {
    final controller = widget.provider.getStarController(i);
    final animation = widget.provider.getStarAnimation(i);
    controller.addListener(() {
      widget.provider.updateRating(controller.value);
    });

    animation.addListener(() {
      if (animation.isCompleted) {
        if (i < (_starCount - 1)) {
          controllerCall(i + 1);
        }
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_starCount, (index) {
          return Consumer(builder: (BuildContext context,
              RatingChangeProvider provider, Widget? child) {
            provider = widget.provider;
            return SingleStar(fillAmount: provider.getAnimationValue(index));
          });
        }));
  }

  @override
  void dispose() {
    for (int i = 0; i < _starCount; i++) {
      widget.provider.getStarController(i).dispose();
    }
    super.dispose();
  }
}
