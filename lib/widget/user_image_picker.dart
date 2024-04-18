import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key,required this.onImagePicked});

  final Function(File fileName) onImagePicked;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
 File? _pickedImgFile;
  void _pickImage() async{
   final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 40,maxWidth: 150);
    if(pickedImage == null){
      return;
    }
   setState(() {
     _pickedImgFile = File(pickedImage.path);
   });
    widget.onImagePicked(_pickedImgFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImgFile != null ? FileImage(_pickedImgFile!) : null,
        ),
        TextButton.icon(onPressed: _pickImage, icon: const Icon(Icons.image),label: Text('Add Image',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary
        ),))
      ],
    );
  }
}
