
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{
}

class WidgetClickNavigationEvent extends HomeEvent{
  final String detailsData;
  WidgetClickNavigationEvent({required this.detailsData});
}
