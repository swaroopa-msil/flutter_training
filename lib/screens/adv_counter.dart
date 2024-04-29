import 'package:flutter/material.dart';
import 'package:march09/bloc/advanced_bloc.dart';
import 'package:march09/bloc/bloc_provider.dart';

class AdvancedCounter extends StatelessWidget {
  const AdvancedCounter({super.key});

  @override
  Widget build(BuildContext context) {
    AdvancedBloc counterBloc = BlocProvider.of<AdvancedBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Advanced counter screen ')
        ),
        body: StreamBuilder(
          stream: counterBloc.getEvent,
          initialData: counterBloc.value,
          builder: (context,snapshot){
            return Center(child:
            Text('${snapshot.data?.value}',style: TextStyle(color: Theme.of(context).colorScheme.onBackground),));
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: counterBloc.decrement,
            child: const Icon(Icons.minimize)
        ),
      );
  }
}
