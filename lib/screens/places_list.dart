import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march09/providers/user_places.dart';

import '../widgets/places_list.dart';
import 'add_place.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final placeList = ref.watch(userPlaceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your place'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
             return const AddPlacesScreen();
            }));
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlaceListWidget(
          placesList: placeList,
        ),
      ),
    );
  }
}
