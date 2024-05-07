
import 'package:march09/model/widget_model.dart';

sealed class HomeState {}
abstract class HomeActionState extends HomeState{}

class HomeInitial extends HomeState {}
class HomeSuccessLoadingState extends HomeState {
  final List<WidgetModel> widgetModelList;
  HomeSuccessLoadingState({
    required this.widgetModelList
});
}
class HomeToWidgetDetailState extends HomeActionState {}



