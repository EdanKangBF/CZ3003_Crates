import 'package:flutter/material.dart';
import '../activity/items.dart';

//Open notificationpage
class NotificationPage extends StatelessWidget {
  final MessageItem messageitem;

  NotificationPage({Key key, @required this.messageitem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.amber[400],
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                icon: const Icon(Icons.keyboard_backspace), // need to change
                onPressed: () {
                  Navigator.pop(context);
                });
          }),
          title: Text("Notification",
              style: TextStyle(fontSize: 30, color: Colors.white)),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(40.0))),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(messageitem.body),
        ));
  }
}
