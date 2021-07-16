import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  final Color colour;
  final CrossAxisAlignment alignment;
  final BorderRadius borderRadius;

  MessageBubble({required this.message,
    required this.sender,
    required this.colour,
    required this.alignment,
    required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            '$sender',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 12.0
            ),
          ),
          Material(
            borderRadius: borderRadius,
            elevation: 5.0,
            color: colour,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$message',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
