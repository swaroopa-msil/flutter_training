
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march09/ui/widgets/single_cell.dart';
import 'package:march09/ui/widgets/sticky_label.dart';
import 'package:march09/utils/app_constants.dart';

import '../../bloc/options_bloc.dart';
import '../../model/data_item.dart';
import '../../utils/option_chain_utils.dart';


class OptionChainParentScroll extends StatefulWidget {
  const OptionChainParentScroll({super.key, required this.bloc});

  final OptionsBloc bloc;

  @override
  State<OptionChainParentScroll> createState() =>
      _OptionChainParentScrollState();
}

class _OptionChainParentScrollState extends State<OptionChainParentScroll> with SingleTickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();
  bool _strikePriceSearched = false;
  double _strikePrice = 0.0;
  double _strikePriceIndex = 0.0;
  double _firstItemValue = 0.0;
  double _lastItemValue = 0.0;
  late  DataModel _dataModel;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(OptionChainLoadEvent());
    _scrollController.addListener(scrollListenerWithItemCount);
  }

  void _scrollToIndex(double index,) {
    _scrollController.animateTo(
      index-1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  scrollListenerWithItemCount() {
    int itemCount = _dataModel.data.length;
    double? scrollOffset = _scrollController.position.pixels;
    double? viewportHeight = _scrollController.position.viewportDimension;
    double? scrollRange = (_scrollController.position.maxScrollExtent) -
        (_scrollController.position.minScrollExtent);
    var lastIndex = (((scrollOffset + (viewportHeight)) /
        (scrollRange + (viewportHeight)) * itemCount) +1 ).floor();
    var firstIndex =
    (((scrollOffset)/ (scrollRange + (viewportHeight)) * itemCount) +2).floor();

    setState(() {
      _firstItemValue = double.parse(_dataModel.data[firstIndex].strikePrice);
      _lastItemValue = double.parse(_dataModel.data[lastIndex].strikePrice);
    });
  }


  List<String> getOptionList(Optionchain header,int index){
    List<String> list = [];
    List<DataItem> data = _dataModel.data;
    if (header == Optionchain.CALL) {
      list = data[index].call;
    } else if (header == Optionchain.PUT) {
      list = data[index].put;
    } else {
      list.add(data[index].strikePrice);
    }
    return list;
  }



  List<Widget> _getInnerList(List<DataItem> data, cellCount,
      {Color color = Colors.black, Optionchain header = Optionchain.CALL}) {
    return List.generate(data.length, (index) {
      var list = getOptionList(header,index);
      return Container(
        color: color,
        child: Row(
          children:
          List.generate(cellCount, (index) {
            return SingleCell(displayValue:  list[index], index: index,header:header);
          })
        ),
      );
    });
  }

  void strikePriceSearched(StrikePriceSearchedState state){
    _strikePrice = state.strikePrice;
    _strikePriceSearched = true;
    _strikePriceIndex = state.strikePriceIndex * 40;
    _scrollToIndex(_strikePriceIndex);
  }

  Widget getSingleRow(){
    return    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children:
                _getInnerList(_dataModel.data, 3, header: Optionchain.CALL),
              ),
            )),
        Column(
          children: _getInnerList(
              _dataModel.data,
              header: Optionchain.STRIKE,
              1,
              color: const Color.fromARGB(255, 8, 47, 13)),
        ),
        Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: _getInnerList(_dataModel.data, header: Optionchain.PUT, 3),
              ),
            ))
      ],
    );
  }

  Widget getStickyHeaderWidget() {
    if (_firstItemValue >= _strikePrice) {
      return Positioned(
          top: 0,
          left: (MediaQuery.of(context).size.width / 2) - (100 / 2),
          child: StickyLabel(strikePrice: _strikePrice));
    } else if (_lastItemValue <= _strikePrice) {
      return Positioned(
          bottom: 0,
          left: (MediaQuery.of(context).size.width / 2) - (100 / 2),
          child: StickyLabel(strikePrice: _strikePrice));
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OptionsBloc, OptionsState>(
      bloc: widget.bloc,
      listenWhen: (prev, curr) => curr is OptionsActionState,
      buildWhen: (prev, curr) => curr is! OptionsActionState,
      listener: (BuildContext context, OptionsState state) {
        if (state is StrikePriceSearchedState) {
          strikePriceSearched(state);
        }
      },
      builder: (context, state) {
        if (state is OptionsLoadingSuccess) {
          _dataModel = state.dataModel;
          if (_dataModel.data.isEmpty) {
            return  Center(
              child: Text(
                AppConstants.NO_DATA_AVAILABLE,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Stack(
                  children: [
                    getSingleRow(),
                    if (_strikePrice > _firstItemValue &&
                        _strikePrice < _lastItemValue &&
                        _strikePriceSearched)
                      Positioned(
                          top: _strikePriceIndex,
                          left: (MediaQuery.of(context).size.width / 2) -
                              (100 / 2),
                          child: StickyLabel(strikePrice: _strikePrice))
                  ],
                ),
              ),
              if (_strikePriceSearched) getStickyHeaderWidget()
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }



  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(scrollListenerWithItemCount);
    super.dispose();
  }
}
