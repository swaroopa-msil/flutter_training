import 'dart:async';

import 'package:march09/bloc/base_bloc.dart';
import 'package:march09/model/counter_model.dart';

class AdvancedBloc extends BaseBloc{
  final _advController = StreamController<CounterModel>();
  StreamSink<CounterModel>  get _pushEvent => _advController.sink;
  Stream<CounterModel>  get getEvent => _advController.stream;

  CounterModel _value = CounterModel(value: 10, date: DateTime.now());

  CounterModel get value => _value;

  @override
  void dispose() {
    _advController.close();
  }

  void decrement(){
    _value = _value.copyWith(
      value: _value.value - 1,
      date: DateTime.now()
    );
    _pushEvent.add(_value);
  }

   AdvancedBloc.updateValue(CounterModel v){
    _value = v;
   }

  AdvancedBloc(){
    _pushEvent.add(_value);
  }

}