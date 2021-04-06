import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String username;
  final String chatUserId;
  final String currentUserId;
  AnimationController animationController;

  ChatMessage({
    String text,
    String imageUrl,
    String username,
    String chatUserId,
    String currentUserId,
    AnimationController animationController,
  })  : text = text,
        imageUrl = imageUrl,
        username = username,
        chatUserId = chatUserId,
        currentUserId = currentUserId,
        animationController = animationController;

//check if message is image or text
  Map<String, dynamic> toMap() => imageUrl == null
      ? {
          'text': text,
          'username': username,
          'chatUserId': chatUserId,
          'currentUserId': currentUserId
        }
      : {
          'imageUrl': imageUrl,
          'username': username,
          'chatUserId': chatUserId,
          'currentUserId': currentUserId
        };

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(child: Text(username[0])),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(username,
                        style: Theme.of(context).textTheme.subtitle1),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: imageUrl == null
                          ? Text(text)
                          : Image.network(imageUrl),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
