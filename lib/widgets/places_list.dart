import 'package:flutter/material.dart';
import 'package:march09/models/places.dart';
import 'package:march09/screens/places_detail.dart';

class PlaceListWidget extends StatelessWidget {
  const PlaceListWidget({super.key, required this.placesList});

  final List<Places> placesList;

  @override
  Widget build(BuildContext context) {
    if(placesList.isEmpty){
      return  Center(child: Text('No data is available',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground)));
    }

    return ListView.builder( itemCount: placesList.length,
        itemBuilder: (ctx,ind) {
      return ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(placesList[ind].image),
        ),
        title: Text(placesList[ind].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground)),
        subtitle: Text(placesList[ind].location.address,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground)),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return PlaceDetailScreen(place: placesList[ind]);
          }));
        },
      );
    });
  }
}
