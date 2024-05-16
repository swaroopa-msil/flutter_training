import 'package:flutter/material.dart';
import 'package:march09/home/utils/app_constants.dart';
import 'package:march09/home/utils/sorting_enum.dart';

import '../../bloc/home_bloc.dart';

class SortingWidget extends StatefulWidget {
  const SortingWidget({super.key, required this.homeBloc});

  final HomeBloc homeBloc;
  @override
  State<SortingWidget> createState() => _SortingWidgetState();
}

class _SortingWidgetState extends State<SortingWidget> {

  late Sorting selectedLabel;
  Color selectedLabelColor = Colors.black;
  @override
  void initState() {
    selectedLabel = widget.homeBloc.selectedLabel[widget.homeBloc.currentTab];
    super.initState();
  }

  /// for selecting color for sorting label and button icon
  Color getColor(String key,bool isLabel){
    if(isLabel && selectedLabel.name.endsWith(key)){
      return Theme.of(context).colorScheme.primary;
    }
    if(selectedLabel.name == key){
      return Theme.of(context).colorScheme.primary;
    }
    return Colors.black;
  }

  /// for setting selected sorting label
  void getSortingLabel(Sorting label,Sorting clicked){
    final Sorting selectLabel;
    switch(label) {
      case Sorting.BYNAME:
        {
          selectedLabelColor = Theme.of(context).colorScheme.primary;
          if (clicked == Sorting.ASC) {
            selectLabel = Sorting.ASCBYNAME;
          } else {
            selectLabel = Sorting.DESCBYNAME;
          }
        }
        break;
      case Sorting.BYCONTACT:
        {
          selectedLabelColor = Theme.of(context).colorScheme.primary;
          if (clicked == Sorting.ASC) {
            selectLabel = Sorting.ASCBYCONTACT;
          } else {
            selectLabel = Sorting.DESCBYCONTACT;
          }
        }
        break;
      default:
        selectLabel = Sorting.NONE;
    }
    setState(() {
      selectedLabel = selectLabel;
    });
  }

  /// for creating sorting row based on label
  Widget getSortRow(String title, Sorting bySort){
    return  Row(
      children: [
        Text(title,style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: getColor(bySort.name,true)
        ),),
        const Spacer(),
        IconButton( icon: Icon(Icons.arrow_upward,color: getColor('${Sorting.ASC.name}${bySort.name}',false)), onPressed: () {
         getSortingLabel(bySort,Sorting.ASC);
         widget.homeBloc.add(SortAscOrDEscButtonClickEvent(sortingLabel: selectedLabel));
        },),
        const SizedBox(width: 5),
        IconButton(icon: Icon(Icons.arrow_downward,color: getColor('${Sorting.DESC.name}${bySort.name}',false)), onPressed: () {
          getSortingLabel(bySort,Sorting.DESC);
          widget.homeBloc.add(SortAscOrDEscButtonClickEvent(sortingLabel: selectedLabel));
        },),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getSortRow(AppConstant.SORT_BY_NAME_LABEL,Sorting.BYNAME),
        const SizedBox(height: 10),
        getSortRow(AppConstant.SORT_BY_CONTACT_LABEL,Sorting.BYCONTACT)
      ],
    );
  }
}
