import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/Chat/chatscreenv2.dart';
//import 'package:flutter_application_1/Chat/chatscreen.dart';

class ChatUserScreen extends StatefulWidget {
  ChatUserScreen({Key key, this.currentUserId}) : super(key: key);

  final currentUserId;

  @override
  _ChatUserScreenState createState() => _ChatUserScreenState(currentUserId);
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  final _currentUserId;

  _ChatUserScreenState(currentUserId) : _currentUserId = currentUserId;

  final ScrollController listScrollController = ScrollController();
  Query _ref;
  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('/users')
        .orderByChild('username');
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
                    print('chatuser: ' + chatUser['userID']);
                    print(_currentUserId);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  peerId: _currentUserId,
                                  peerAvatar: "test",
                                  // chatUserId: chatUser['userID'].toString(),
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

      // Container(
      //     child: StreamBuilder(
      //         stream: _ref.onValue,
      //         builder: (context, snapshot) {
      //           if (!snapshot.hasData) {
      //             return Center(
      //               child: CircularProgressIndicator(
      //                 valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      //               ),
      //             );
      //           } else {
      //             return ListView.builder(
      //                 itemBuilder: (context, index) =>
      //                     (buildItem(context, snapshot.data)));
      //           }
      //         }))
    );
  }
}
