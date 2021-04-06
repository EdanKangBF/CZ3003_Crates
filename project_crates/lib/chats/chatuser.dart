import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter_application_1/Chat/chatscreenv2.dart';
import 'package:flutter_application_1/chats/chatscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatUserScreen extends StatefulWidget {
  @override
  _ChatUserScreenState createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  final ScrollController listScrollCOntroller = ScrollController();
  String currentUserId;
  Query _ref;

  @override
  void initState() {
    super.initState();
    //TODO: retrieve Conversations based on current userid
    _ref = FirebaseDatabase.instance
        .reference()
        .child('/users')
        .orderByChild('username');

    getUID().then((uid) {
      setState(() {
        currentUserId = uid;
      });
    });
  }

  Future<String> getUID() async {
    var user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  Widget _buildChatItem({Map chatUser}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        height: 100,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                SizedBox(width: 6),
                Text(chatUser['username'],
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600)),
                SizedBox(width: 20),
                Text(chatUser['userID'],
                    style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 6),
                Text(
                  chatUser['email'],
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print('currentUserId: ' + currentUserId);
                    print('chatUserId: ' + chatUser['userID']);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  currentUserId: currentUserId,
                                  chatUserId: chatUser['userID'].toString(),
                                )));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.message, color: Theme.of(context).primaryColor)
                    ],
                  ),
                ),
                SizedBox(width: 6)
              ],
            )
          ],
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
              query: _ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map chatUser = snapshot.value;
                return _buildChatItem(chatUser: chatUser);
              })),


    );
  }
}
