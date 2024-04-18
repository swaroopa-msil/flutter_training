import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NewMessage extends StatefulWidget {
   const NewMessage({super.key});


  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _newMessageController = TextEditingController();

  void _sendMessage() async{
    final mesg = _newMessageController.text;
    if(mesg.trim().isEmpty){
      return;
    }
    FocusScope.of(context).unfocus();
    _newMessageController.clear();

    final user = FirebaseAuth.instance.currentUser!;
    final data = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FirebaseFirestore.instance.collection('chat').add(
     {
       'text': mesg,
       'createdAt': Timestamp.now(),
       'userId': user.uid,
       'username': data.data()!['username'],
       'userImage' : data.data()!['image_url']
     }
    );
  }

  @override
  void dispose() {
    _newMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Send text ...'
                ),
                controller: _newMessageController,
              ),
            ),
            IconButton(onPressed: _sendMessage, icon: const Icon(Icons.send,color: Colors.green))
          ],
        ),
    );
  }
}
