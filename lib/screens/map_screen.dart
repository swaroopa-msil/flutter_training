import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:march09/models/places.dart';


class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location = const PlaceLocation(
          latitude: 37.422, longitute: -122.084, address: ''),
      this.isSelected = true});

  final PlaceLocation location;
  final bool isSelected;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLoc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( widget.isSelected ? 'Pick your location' : 'Your location'),
        actions: [
         if(widget.isSelected)
          IconButton(onPressed: (){
            Navigator.of(context).pop(_pickedLoc);
          }, icon: Icon(Icons.save))
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelected ? null : (position){
            setState(() {
              _pickedLoc = position;
            });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
           widget.location.longitute,
            widget.location.latitude
          ),
          zoom: 16
        ),
        markers: (_pickedLoc==null && widget.isSelected) ? {} : {
          Marker(
              markerId: const MarkerId('m1'),
              position: _pickedLoc ?? LatLng(
                  widget.location.longitute,
                  widget.location.latitude
              )
          )
        },
      ),
    );
  }
}
