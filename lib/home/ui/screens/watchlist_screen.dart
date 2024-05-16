import 'package:flutter/material.dart';

import '../../model/contact_model.dart';
import '../widget/list_view_item.dart';
class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key, required this.contactList, required this.scrollController});
 final List<ContactModel> contactList;

  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: scrollController,
      itemCount: contactList.length,
        itemBuilder: (context,index){
      return WatchlistItem(item: contactList[index]);
    }
    );
  }
}
