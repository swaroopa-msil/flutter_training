import 'package:flutter/material.dart';

import '../../model/contact_model.dart';

class WatchlistItem extends StatelessWidget {
  const WatchlistItem({super.key, required this.item});

  final ContactModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.primary,width: 1),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary)),
              Text(item.contact,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onSecondaryContainer))
              ]
              ),
              const Spacer(),
              Container(
                color: Theme.of(context).colorScheme.primary,height: 30,width: 30,
                child:  Icon(Icons.person_outline , color: Theme.of(context).colorScheme.background),
              )
            ],
          ),
      );
  }
}
