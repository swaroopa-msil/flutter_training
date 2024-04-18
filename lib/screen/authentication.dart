import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widget/user_image_picker.dart';
import 'dart:io';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

final firebase = FirebaseAuth.instance;

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _isLogin = true;
  final _form = GlobalKey<FormState>();
  String? _enteredEmail;
  String? _enteredPassWord;
  String _enteredUserName = '';
  File? _selectedImage;
  bool _isAuthenticating = false;

  void _submit() async{
  final isValid =  _form.currentState!.validate();
  if(!isValid || !_isLogin && _selectedImage == null){
       return;
  }
  _form.currentState!.save();
  try{
    setState(() {
      _isAuthenticating = true;
    });
  if(_isLogin){
    final credential = await firebase.signInWithEmailAndPassword(email: _enteredEmail!, password: _enteredPassWord!);
  }else{
    final credential = await firebase.createUserWithEmailAndPassword(email: _enteredEmail!, password: _enteredPassWord!);
    final storageRef = FirebaseStorage.instance.ref().child('user_images').child('${credential.user!.uid}.jpg');
    storageRef.putFile(_selectedImage!);
   final imageUrl =  await storageRef.getDownloadURL();
   await FirebaseFirestore.instance.collection('users').doc( credential.user!.uid).set(
     {
       'username':_enteredUserName,
       'email': _enteredEmail,
       'image_url':imageUrl
     }
   );
  }
  } on FirebaseAuthException catch(error){
  ScaffoldMessenger.of(context).clearSnackBars();
  if(error.code == 'email-already-in-use'){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? 'Authentication failed')));
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? 'Authentication failed')));
  }
 setState(() {
   _isAuthenticating = false;
 });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline,color:Theme.of(context).colorScheme.onPrimary ,size: 200),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            if(!_isLogin)
                               UserImagePicker(onImagePicked: (pickedImage){
                                _selectedImage = pickedImage;
                              } ),
                             TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Email'
                              ),
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              validator: (value){
                                if(value == null || value.trim().isEmpty || !value.contains('@')){
                                  return 'Please enter valid emailId';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _enteredEmail = value;
                              },
                            ),
                            if(!_isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'UserName'
                              ),
                              enableSuggestions: false,
                              validator: (value){
                                if(value == null || value.trim().isEmpty || value.trim().length <4){
                                  return 'Please enter valid username';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _enteredUserName = value!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Password'
                              ),
                              obscureText: true,
                              validator: (value){
                                if(value == null || value.trim().length <6){
                                 return 'Please enter password with more than 6 letters';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _enteredPassWord = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if(_isAuthenticating)
                    const CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  if(!_isAuthenticating)
                  ElevatedButton.icon(onPressed: _submit,
                      icon: const Icon(Icons.login),label: Text(
                      _isLogin ? 'Login' : 'SignUp'
                  )),
                  const SizedBox(height: 10),
                  if(!_isAuthenticating)
                  TextButton(onPressed: (){
                   setState(() {
                     if(_form.currentState != null){
                       _form.currentState!.reset();
                     }
                     _isLogin = !_isLogin;
                   });
                  }, child: Text(
                      _isLogin ? 'Create a new Account' : 'Already have an Account',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary
                    ),
                  ))

                ],
              ),

        ),
      ),
    );
  }
}
