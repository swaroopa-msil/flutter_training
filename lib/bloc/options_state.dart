part of 'options_bloc.dart';

@immutable
abstract class OptionsState {}
abstract class OptionsActionState extends OptionsState {}

final class OptionsInitial extends OptionsState {}

class OptionsLoadingSuccess extends OptionsState {
  final DataModel dataModel;
  OptionsLoadingSuccess({
    required this.dataModel,
});
}
class StrikePriceSearchedState extends OptionsActionState {
  final double strikePriceIndex;
  final double strikePrice;
  StrikePriceSearchedState({
    required this.strikePriceIndex,
    required this.strikePrice,
});
}

