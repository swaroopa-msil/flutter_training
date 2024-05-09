import 'package:flutter/material.dart';

import '../widgets/multi_star_rating_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Future openAlertDialog(BuildContext context,String value){
      return  showDialog(context: context,
          builder: (context){
            return  AlertDialog(
              title: Text('Thank you'),
              content: MultiStarRatingBar(rating:double.parse(value)),
              actions:<Widget>[
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            );
          }
      );
    }

    String? validateRateFiled(String? value){
      if(value?.isEmpty == true || value ==  null){
        return 'Rate field can not leave empty';
      }
      final rate = double.parse(value);
      if(rate > 6){
        return 'Please enter a rating maximum of 5';
      }
      return null;
    }


    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:0,horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Please Rate us with 0 to 5',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height:10),
                TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter your rating here',
                  ),
                  validator: (value) {
                      return validateRateFiled(value);
                    }
                ),
                const SizedBox(height:20),
                FloatingActionButton(onPressed: (){
                  if(formKey.currentState?.validate() == true){
                     openAlertDialog(context,controller.text);
                     controller.clear();
                  }
                }, child: const Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
