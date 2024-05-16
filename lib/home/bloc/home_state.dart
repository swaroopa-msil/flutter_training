part of 'home_bloc.dart';

abstract class HomeState {}
abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState{}
class HomeLoadingSuccess extends HomeState{
  final List<ContactModel> contactList;
  HomeLoadingSuccess({
    required this.contactList
});
}
class HomeLoadingError extends HomeState{
  final String errorMessage;
  HomeLoadingError({
    required this.errorMessage
});
}

class SortDialogLoadingSuccess extends HomeActionState{
  final Sorting selectedLabel;
  SortDialogLoadingSuccess({
    required this.selectedLabel
  });
}
