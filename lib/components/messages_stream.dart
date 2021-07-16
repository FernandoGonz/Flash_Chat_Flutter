import 'package:flutter/material.dart';
import 'message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessagesStream extends StatelessWidget {

  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  MessagesStream({required this.firestore, required this.auth});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Iterable<QueryDocumentSnapshot<Object?>> messages =
              snapshot.data!.docs.reversed;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages) {
            final messageText = message.get('message');
            final senderText = message.get('sender');
            messageWidgets.add(
              MessageBubble(
                message: messageText,
                sender: senderText,
                colour: auth.currentUser!.email == senderText
                    ? Colors.lightBlueAccent
                    : Colors.deepPurple,
                alignment: auth.currentUser!.email == senderText
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                borderRadius: auth.currentUser!.email == senderText
                    ? BorderRadius.only(topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),)
                    : BorderRadius.only(topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
              ),
            );
          }
          return Expanded(
            flex: 1,
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageWidgets,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          ),
        );
      },
    );
  }
}
