part of 'home_bloc.dart';

abstract class HomeEvent {}

class InitialDataLoadingEvent extends HomeEvent {}
class FloatingSortButtonClickedEvent extends HomeEvent {
}
class SortAscOrDEscButtonClickEvent extends HomeEvent {
  final Sorting sortingLabel;
  SortAscOrDEscButtonClickEvent({
    required this.sortingLabel
});
}
class ContactTabClickedEvent extends HomeEvent {
  final int tabIndex;
  ContactTabClickedEvent({
    required this.tabIndex
});
}