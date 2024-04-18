import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:march09/widget/message_bubble.dart';

class ChatMessage extends StatefulWidget {
  const ChatMessage({super.key});

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {

  final authUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',
        descending: true).snapshots()
        , builder: (ctx,snapShot){
            if(snapShot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }
            if(!snapShot.hasData || snapShot.data!.docs.isEmpty){
              return const Text('No messages found');
            }
            final mesges = snapShot.data!.docs;
            return ListView.builder(
              reverse: true,
              padding: const EdgeInsets.only(bottom: 40,left: 13,right: 13),
              itemCount: mesges.length,
                itemBuilder: (ctx,ind){
                final chat = mesges[ind].data()['text'];
                final nextChat = ind +1 < mesges.length ? mesges[ind + 1].data()['text'] : null;
                final cUser = chat['userId'];
                final nUser = nextChat ? nextChat['userId'] : null;
                final isSameUser =  cUser == nUser;
                if(isSameUser){
                  return MessageBubble.next( message: chat['text'], isMe: authUser.uid == cUser) ;
                }else{
                  return MessageBubble.first(userImage: nextChat['userImage'],
                      username: nextChat['username'], message: nextChat['text'], isMe: false);
                }
            }
            );
        });
  }
}
