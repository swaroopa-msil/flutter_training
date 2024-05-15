import 'package:flutter/material.dart';
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
  @override
  void initState() {
    selectedLabel = widget.homeBloc.selectedLabel[widget.homeBloc.currentTab];
    super.initState();
  }

  Color getColor(String key){
    if(selectedLabel.name == key){
      return Colors.blue;
    }
    return Colors.black;
  }

  void getSortingLabel(Sorting label,Sorting clicked){
    switch(label) {
      case Sorting.BYNAME:
        {
          if (clicked == Sorting.ASC) {
            selectedLabel = Sorting.ASCBYNAME;
          } else {
            selectedLabel = Sorting.DESCBYNAME;
          }
        }
        break;
      case Sorting.BYCONTACT:
        {
          if (clicked == Sorting.ASC) {
            selectedLabel = Sorting.ASCBYCONTACT;
          } else {
            selectedLabel = Sorting.DESCBYCONTACT;
          }
        }
        break;
      default:
        selectedLabel = Sorting.NONE;
    }
  }

  Widget getSortRow(String title, Sorting bySort){
    return  Row(
      children: [
        Text(title,style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),),
        const Spacer(),
        IconButton( icon: Icon(Icons.arrow_upward,color: getColor('${Sorting.ASC.name}${bySort.name}')), onPressed: () {
          setState(() {
              getSortingLabel(bySort,Sorting.ASC);
          });
         widget.homeBloc.add(SortAscOrDEscButtonClickEvent(sortingLabel: selectedLabel));
        },),
        const SizedBox(width: 5),
        IconButton(icon: Icon(Icons.arrow_downward,color: getColor('${Sorting.DESC.name}${bySort.name}')), onPressed: () {
          setState(() {
             getSortingLabel(bySort,Sorting.DESC);
          });
          widget.homeBloc.add(SortAscOrDEscButtonClickEvent(sortingLabel: selectedLabel));
        },),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getSortRow('Sort by name',Sorting.BYNAME),
        const SizedBox(height: 10),
        getSortRow('Sort by contact',Sorting.BYCONTACT)
      ],
    );
  }
}
