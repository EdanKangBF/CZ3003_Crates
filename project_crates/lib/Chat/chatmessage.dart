import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String username;
  final String chatUserId;
  final String currentUserId;
  final AnimationController animationController;
  final DatabaseReference _userDatabaseReference;
  List lists = [];
  String currentUserName = '';

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
        animationController = animationController,
        _userDatabaseReference =
            FirebaseDatabase.instance.reference().child('/users');

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

  Future<void> getUsername() async {
    _userDatabaseReference
        .orderByKey()
        .equalTo(chatUserId)
        .once()
        .then((DataSnapshot snapshot) {
      // Map result = snapshot.value;
      // return result;
      // setState(() {
      //   result = snapshot.value;
      // });
      Map<dynamic, dynamic> values = snapshot.value;
      print(values.toString());
      values.forEach((key, values) {
        print("key : " + key);
        lists.add(values["username"]);
        print("in chat message dart: " + lists[0]);
        currentUserName = values["username"].toString();
      });
    });
  }

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
                child: CircleAvatar(child: Text(currentUserName[0])),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(currentUserName,
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
// class ChatMessage extends StatefulWidget {
//   final String text;
//   final String imageUrl;
//   final String username;
//   final String chatUserId;
//   final String currentUserId;
//   final AnimationController animationController;
//  // final DatabaseReference _userDatabaseReference;
//   // List lists = [];
//   // String currentUserName = '';

//   ChatMessage({
//     String text,
//     String imageUrl,
//     String username,
//     String chatUserId,
//     String currentUserId,
//     AnimationController animationController,
//   })  : text = text,
//         imageUrl = imageUrl,
//         username = username,
//         chatUserId = chatUserId,
//         currentUserId = currentUserId,
//         animationController = animationController;
//   // _userDatabaseReference =
//   //     FirebaseDatabase.instance.reference().child('/users');
//   @override
//   _ChatMessageState createState() => _ChatMessageState(
//       text, imageUrl, username, chatUserId, currentUserId);
// }

// class _ChatMessageState extends State<ChatMessage> {
//   final String text;
//   final String imageUrl;
//   final String username;
//   final String chatUserId;
//   final String currentUserId;
//  // final AnimationController animationController;

//   _ChatMessageState(
//     text,
//     imageUrl,
//     username,
//     chatUserId,
//     currentUserId,
//     //animtationController,
//   )   : text = text,
//         imageUrl = imageUrl,
//         username = username,
//         chatUserId = chatUserId,
//         currentUserId = currentUserId,
//         //animationController = animationController;

//   Map<String, dynamic> toMap() => imageUrl == null
//       ? {
//           'text': text,
//           'username': username,
//           'chatUserId': chatUserId,
//           'currentUserId': currentUserId
//         }
//       : {
//           'imageUrl': imageUrl,
//           'username': username,
//           'chatUserId': chatUserId,
//           'currentUserId': currentUserId
//         };
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
