import 'package:flutter/material.dart';
import 'package:march09/utils/app_constants.dart';

import '../../bloc/options_bloc.dart';


class SearchingBar extends StatelessWidget {
  const SearchingBar({super.key,required this.bloc});
  final OptionsBloc bloc;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Container(
           height: 45,
           decoration: BoxDecoration(
             color: Colors.black,
             borderRadius: BorderRadius.circular(10),
             border: Border.all(color: Colors.grey)
           ),
           child:
           Row(
             children: [
               Expanded(
                 child: TextField(
                   style: const TextStyle(color: Colors.white),
                   controller: textController,
                   keyboardType: TextInputType.number,
                   decoration:  InputDecoration(
                       label: Text(AppConstants.SEARCH_STRIKE_PRICE,style: const TextStyle(color: Colors.grey)),
                   ),
                 ),
               ),
              IconButton(onPressed: (){
                if(textController.text.isNotEmpty){
                  bloc.add(StrikePriceSearchEvent( searchString: double.parse(textController.text)));
                  textController.clear();
                }
              }, icon: const Icon(Icons.search,color: Colors.white,) )
            ],
          ),
      ),
    );
  }
}
