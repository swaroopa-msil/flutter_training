import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march09/models/places.dart';
import 'package:march09/providers/user_places.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlacesScreen extends ConsumerStatefulWidget {
  const AddPlacesScreen({super.key});

  @override
  ConsumerState<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends ConsumerState<AddPlacesScreen> {
  final _controller = TextEditingController();
  File? _selectedFile;
  PlaceLocation? _selectedLocation;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addItem(){
    final title = _controller.text;
    if(title.isEmpty || _selectedFile ==  null || _selectedLocation ==  null){
      return;
    }
    ref.read(userPlaceProvider.notifier).addPlace(title,_selectedFile!,_selectedLocation!);
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 10),
            InputImageWidget(imagePicked:(image){
              _selectedFile = image;
            }),
            const SizedBox(height: 10),
             FetchLocationWidget(
              addLocation: (location){
                _selectedLocation = location;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(onPressed: _addItem , icon: const Icon(Icons.add), label:const Text( 'Add'))
          ],
        ),
      ),
    );
  }
}
