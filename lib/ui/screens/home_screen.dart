import 'package:flutter/material.dart';
import 'package:march09/provider/rating_change_provider.dart';
import 'package:march09/utils/app_constants.dart';
import 'package:provider/provider.dart';

import '../widgets/multi_star_rating_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Future openAlertDialog(BuildContext context,RatingChangeProvider provider){
      return  showDialog(context: context,
          builder: (context){
            return  AlertDialog(
              title: Text(AppConstants.THANK_YOU_TEXT),
              content: MultiStarRatingBar(provider: provider),
              actions:<Widget>[
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(AppConstants.OK_BUTTON_TEXT))
              ],
            );
          }
      );
    }

    String? validateRateFiled(String? value){
      if(value?.isEmpty == true || value ==  null){
        return AppConstants.RATE_FIELD_CAN_NOT_LEAVE_EMPTY;
      }
      final rate = double.parse(value);
      if(rate > 6){
        return AppConstants.PLEASE_ENTER_A_RATING;
      }
      return null;
    }


    return Consumer<RatingChangeProvider>(builder: (BuildContext context,RatingChangeProvider provider,Widget? child){
      return  Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:0,horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppConstants.RATE_US_HEAD_LINE,
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                  const SizedBox(height:10),
                  TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration:  InputDecoration(
                        labelText: AppConstants.ENTER_YOUR_RATING_HERE,
                      ),
                      validator: (value) {
                        return validateRateFiled(value);
                      }
                  ),
                  const SizedBox(height:20),
                  FloatingActionButton(onPressed: (){
                    if(formKey.currentState?.validate() == true){
                      provider.updateRating(double.parse(controller.text));
                      openAlertDialog(context,provider);
                      controller.clear();
                    }
                  }, child:  Text(AppConstants.SUBMIT_BUTTON_TEXT,style: const TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
     
  }
}
