import 'package:flutter/material.dart';

import '../../model/contact_model.dart';
import '../widget/list_view_item.dart';
class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key, required this.contactList});
 final List<ContactModel> contactList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactList.length,
        itemBuilder: (context,index){
      return Expanded(child: WatchlistItem(item: contactList[index]));
    }
    );
  }
}
