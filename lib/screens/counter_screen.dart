import 'package:flutter/material.dart';
import 'package:march09/bloc/CounterBloc.dart';
import 'package:march09/bloc/advanced_bloc.dart';
import 'package:march09/bloc/bloc_provider.dart';
import 'package:march09/model/counter_model.dart';
import 'package:march09/screens/adv_counter.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Ordinary counter screen '),
          actions: [
            IconButton(onPressed: (){
             final valueObj = AdvancedBloc.updateValue(CounterModel(
                value: counterBloc.value,
                date: DateTime.now()
              ));
              Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(blocObject:
              valueObj, widgetObject: const AdvancedCounter())));
            }, icon: const Icon(Icons.arrow_right_alt))
          ]
      ),
      body: StreamBuilder(
        stream: counterBloc.listenEvent,
        initialData: counterBloc.value,
        builder: (context,snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          return Center(child:
          Text('${snapshot.data}',style: TextStyle(color: Theme.of(context).colorScheme.onBackground),));
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: counterBloc.incrementCounter,
          child: const Icon(Icons.add)
      ),
    );
  }
}
