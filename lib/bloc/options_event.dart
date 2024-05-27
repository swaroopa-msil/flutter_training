part of 'options_bloc.dart';

@immutable
abstract class OptionsEvent {}

class OptionChainLoadEvent extends OptionsEvent{}
class StrikePriceSearchEvent extends OptionsEvent{
  final double searchString;
  StrikePriceSearchEvent({
    required this.searchString
});
}
