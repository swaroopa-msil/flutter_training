
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:march09/models/places.dart';

import '../screens/map_screen.dart';

class FetchLocationWidget extends StatefulWidget {
  const FetchLocationWidget({super.key,required this.addLocation});

  final Function(PlaceLocation location) addLocation;
  @override
  State<FetchLocationWidget> createState() => _FetchLocationWidgetState();
}

class _FetchLocationWidgetState extends State<FetchLocationWidget> {
  PlaceLocation? _selectedLoc;
  bool isLoading = false;

  String get locationImage{
    if(_selectedLoc == null){
      return '';
    }
    final lat = _selectedLoc!.latitude;
    final longi = _selectedLoc!.longitute;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$longi&zoom=16&size=600x300&maptype=roadmap &markers=color:blue%7Clabel:S%7C$lat,$longi&markers=color:green%7Clabel:G%7C40.711614,-74.012318 &markers=color:red%7Clabel:C%7C40.718217,-73.998284 &key=YOUR_API_KEY&signature=YOUR_SIGNATURE';

  }

  void _saveState(double lat,double log) async{
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$log}&key=YOUR_API_KEY');
    try {
      final resp = await http.get(url);
      final resdata = json.decode(resp.body);
      final address = resdata['result'][0]['formatted_address'];
      setState(() {
        _selectedLoc = PlaceLocation(latitude: lat,
            longitute: log,
            address: address);
      });
      widget.addLocation(_selectedLoc!);
    }
    catch(error){
      print('api error');
    }
    setState(() {
      isLoading = false;
    });
  }

  void _addMap() async {
   final loc = await Navigator.of(context).push<LatLng>(MaterialPageRoute(builder:
        (ctx){
      return const MapScreen();
    }
    ));
   if(_selectedLoc == null){
     return;
   }
   _saveState(_selectedLoc!.latitude,_selectedLoc!.longitute);
  }

  void _addLocation() async{
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isLoading = true;
    });
    locationData = await location.getLocation();
    if(locationData.latitude == null || locationData.longitude == null){
      return;
    }
    _saveState(locationData.latitude!,locationData.longitude!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content =  Text('No location added',
      style: TextStyle(color: Theme.of(context).colorScheme.onBackground));

    if(isLoading){
      content =  const CircularProgressIndicator();
    }

    if(_selectedLoc != null){
      content = Image.network(locationImage,fit: BoxFit.cover,width: double.infinity,height: double.infinity);
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Theme.of(context).colorScheme.onBackground),
          ),
          child:  content,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(onPressed: _addLocation, icon: const Icon(Icons.location_pin),label: const Text('Get current location'),),
            TextButton.icon(onPressed: _addMap, icon: const Icon(Icons.map),label: const Text('Add Location'),),
          ],
        )
      ],
    );
  }
}
