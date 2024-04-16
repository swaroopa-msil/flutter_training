import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputImageWidget extends StatefulWidget {
  const InputImageWidget({super.key,required this.imagePicked});

  final Function(File image) imagePicked;

  @override
  State<InputImageWidget> createState() => _InputImageWidgetState();
}

class _InputImageWidgetState extends State<InputImageWidget> {
  File? _selectedImage;

  void _takePicture() async{
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(source: ImageSource.camera,maxWidth: 600);

      if(image == null ){
        return;
      }
 setState(() {
   _selectedImage = File(image.path);
 });
     widget.imagePicked(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(onPressed: _takePicture, icon: const Icon(Icons.camera), label: const Text('Take picture'));
   if(_selectedImage != null){
     content =
         GestureDetector(onTap: _takePicture,child:
     Image.file(_selectedImage!,fit: BoxFit.cover,width: double.infinity)
    );
   }
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Theme.of(context).colorScheme.onBackground),
      ),
      child: content,
    );
  }
}
