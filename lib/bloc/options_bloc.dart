import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/option_chain_data.dart';
import '../model/data_item.dart';

part 'options_event.dart';
part 'options_state.dart';

class OptionsBloc extends Bloc<OptionsEvent, OptionsState> {
  OptionsBloc() : super(OptionsInitial()) {
    on<OptionChainLoadEvent>(optionChainLoadEvent);
    on<StrikePriceSearchEvent>(strikePriceSearchEvent);
  }

  FutureOr<void> optionChainLoadEvent(OptionChainLoadEvent event, Emitter<OptionsState> emit) {
    emit(OptionsLoadingSuccess(dataModel: getData()));
  }

  FutureOr<void> strikePriceSearchEvent(StrikePriceSearchEvent event, Emitter<OptionsState> emit) {
    final dataModel = getData();
    final index = _findIndexByStrikePrice(dataModel,event.searchString);
    emit(StrikePriceSearchedState(strikePriceIndex: double.parse(index.toString()), strikePrice: event.searchString));
    emit(OptionsLoadingSuccess(dataModel: getData()));
  }

  DataModel getData(){
    Map<String, dynamic> jsonData = jsonDecode(OptionChainData.jsonString);
    return DataModel.fromJson(jsonData);
  }

  int _findIndexByStrikePrice(DataModel dataList,double strikePrice) {
      for (int i = 0; i < dataList.data.length; i++) {
         double sp = double.parse(dataList.data[i].strikePrice);
         double prevSp = 0.0;
         if(i != 0)
         {
           prevSp =   double.parse(dataList.data[i-1].strikePrice);
         }
        if ((sp == strikePrice) || ( strikePrice < sp && strikePrice > prevSp)){
          return i;
        }
      }
    return 0;
  }
}
