import 'dart:async';
import 'package:march09/model/movie_model.dart';

import 'base_bloc.dart';

class MovieBloc implements BaseBloc{
 final _streamController = StreamController<List<MovieModel>>.broadcast();
 List<MovieModel> _value = [];
 List<MovieModel> get value => _value;

 StreamSink<List<MovieModel>> get _pushEvent => _streamController.sink;
 Stream<List<MovieModel>> get listenEvent => _streamController.stream;

 MovieBloc(){
  _pushEvent.add(value);
 }

 void addToList(MovieModel model){
   _value.add(model);
   _pushEvent.add(_value);
 }

 @override
  void dispose(){
   _streamController.close();
 }

}
