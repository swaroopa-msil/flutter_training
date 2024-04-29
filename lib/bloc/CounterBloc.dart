import 'dart:async';
import 'base_bloc.dart';

class CounterBloc implements BaseBloc{
 //final _streamController = StreamController<int>.broadcast(); for multiple listening
 final _streamController = StreamController<int>();
  int _value = 0;
 int get value => _value;

 StreamSink<int> get _pushEvent => _streamController.sink;
 Stream<int> get listenEvent => _streamController.stream;

 CounterBloc(){
  _pushEvent.add(value);
 }

 void incrementCounter(){
  _value = value + 1 ;
   _pushEvent.add(value );
 }

 // void decrementCounter(){
 //  _value = value - 1 ;
 //  _pushEvent.add(value );
 // }

 @override
  void dispose(){
   _streamController.close();
 }

}
