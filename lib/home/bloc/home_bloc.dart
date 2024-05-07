import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:march09/model/widget_model.dart';

import '../../data/data_details.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<WidgetClickNavigationEvent>(widgetClickNavigationEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) {
    final widgetModel = WidgetDetails.widgetDetailsList.map((e) =>
        WidgetModel(details: e['details']??'', Title: e['title']??'', key: e['key']??"")).toList();
    emit(HomeSuccessLoadingState(widgetModelList: widgetModel));
  }

  FutureOr<void> widgetClickNavigationEvent(WidgetClickNavigationEvent event, Emitter<HomeState> emit) {
    emit(HomeToWidgetDetailState());
  }
}
