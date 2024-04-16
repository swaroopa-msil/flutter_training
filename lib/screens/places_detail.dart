import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:march09/models/places.dart';
import 'package:march09/screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key,required this.place});

  final Places place;

  String get locationImage{
    final lat = place.location.latitude;
    final longi = place.location.longitute;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$longi&zoom=16&size=600x300&maptype=roadmap &markers=color:blue%7Clabel:S%7C$lat,$longi&markers=color:green%7Clabel:G%7C40.711614,-74.012318 &markers=color:red%7Clabel:C%7C40.718217,-73.998284 &key=YOUR_API_KEY&signature=YOUR_SIGNATURE';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Stack(
        children: [
          Image.file(place.image,fit: BoxFit.cover,width: double.infinity,height: double.infinity),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
            children: [
              GestureDetector(
                child: CircleAvatar(radius: 70,backgroundImage: NetworkImage(locationImage)),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:
                  (ctx){
                   return MapScreen(location: place.location, isSelected: false);
                  }
                  ));
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Colors.black54
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
                alignment: Alignment.center,
                child: Text(place.location.address,style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
                textAlign: TextAlign.center,),
              )
            ],
          ),)
        ],
      ),
    );
  }
}
