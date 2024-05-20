import 'package:flutter/material.dart';
import 'package:march09/utils/evaluate_mixin.dart';
import 'package:march09/utils/evaluation_utils.dart';
class ExpressionEvaluatorScreen extends StatefulWidget{
  const ExpressionEvaluatorScreen({super.key});

  @override
  State<ExpressionEvaluatorScreen> createState() => _ExpressionEvaluatorScreenState();
}

class _ExpressionEvaluatorScreenState extends State<ExpressionEvaluatorScreen>  with ExpressionValidation{
  final _formKey = GlobalKey<FormState>();
  final _expEvalController = TextEditingController();
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 100),
        child: Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(width: 2,color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Form(
                key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        child: TextFormField(
                          controller: _expEvalController,
                          decoration: const InputDecoration(
                              labelText: 'Enter the expression here'
                          ),
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid expression';
                            }else if(hasInvalidOperator(value) || !containsDigit(value)){
                              return 'Please enter valid expression';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(onPressed: (){
                        if(_formKey.currentState?.validate() == true){
                          final ob =ExpEvaluator();
                          setState(() {
                            result = ob.evaluateExpression(_expEvalController.text);
                          });
                          _expEvalController.clear();
                        }

                      }, child: const Text('EVALUATE')),
                      const SizedBox(height: 20),
                       Text('Evaluated result is',style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                       Text(result.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                    ],
                  )
              ),
          ),
        ),
      ),

    );
  }
}
