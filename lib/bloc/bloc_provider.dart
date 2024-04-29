import 'package:march09/bloc/base_bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider<T extends BaseBloc> extends StatefulWidget {
  const BlocProvider({super.key,required this.blocObject,required this.widgetObject});

  final Widget widgetObject;
  final T blocObject;

  @override
  State<BlocProvider> createState() => _BlocProviderState();

  static T of<T extends BaseBloc>(BuildContext context){
    BlocProvider<T> provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>() as BlocProvider<T>;
    return provider.blocObject;
  }
}

class _BlocProviderState extends State<BlocProvider> {

   @override
  void dispose() {
    widget.blocObject.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.widgetObject;
  }
}
