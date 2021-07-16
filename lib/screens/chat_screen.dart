import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/messages_stream.dart';

class ChatScreen extends StatefulWidget {

  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String messageText = '';
  String user = '';
  final textFieldController = TextEditingController();

  void getCurrentUser() {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        user = currentUser.email.toString();
        print(user);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   // get collection of the data in FireStore
  //   final messages = await _firestore.collection('messages').get();
  //   // loop for get any document (message), each document return a Map<String, dynamic>
  //   for (var doc in messages.docs) {
  //     print(doc.data());
  //   }
  //
  // }

  void getMessagesStream() async {
    // get collection of the data in FireStore in RealTime
    await for (var snapShot in _firestore.collection('messages').snapshots()) {
      for (var doc in snapShot.docs) {
        print(doc.data());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getMessagesStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('⚡️Chat'),
        leading: null,
        actions: [
          IconButton(
            onPressed: () async {
              // Implement logout functionality
              await _auth.signOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessagesStream(
              firestore: _firestore,
              auth: _auth,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: textFieldController,
                      onChanged: (value) {
                        // Do something with the user input
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Implement send functionality
                      if (messageText != '') {
                        await _firestore.collection('messages').add(
                          {'message': messageText, 'sender': user},
                        );
                        textFieldController.clear();
                      } else {
                        print('Empty message');
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

