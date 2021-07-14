import 'package:flutter/material.dart';
import 'message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesStream extends StatelessWidget {

  final FirebaseFirestore firestore;

  MessagesStream({required this.firestore});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<QueryDocumentSnapshot> messages =
              snapshot.data!.docs;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages) {
            final messageText = message.get('message');
            final senderText = message.get('sender');
            messageWidgets.add(
              MessageBubble(
                message: messageText,
                sender: senderText,
              ),
            );
          }
          return Expanded(
            flex: 1,
            child: ListView(
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
