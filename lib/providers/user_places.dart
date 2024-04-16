
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/places.dart';

class UserPlacesNotifier extends StateNotifier<List<Places>>{
  UserPlacesNotifier():super([]);

  void addPlace(String title,File image,PlaceLocation location){
    final place = Places(title: title,image: image,location: location);
    state = [place,...state];
  }

}

final userPlaceProvider = StateNotifierProvider<UserPlacesNotifier,List<Places>>((ref) => UserPlacesNotifier());