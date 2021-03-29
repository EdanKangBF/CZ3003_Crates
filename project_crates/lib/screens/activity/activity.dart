import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../activity/items.dart';
import '../activity/chatpage.dart';
import '../activity/notificationpage.dart';

class ActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.amber[400],
          title: Text("Activity page",
              style: TextStyle(fontSize: 30, color: Colors.white)),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(40.0))),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 0,
            color: Colors.pink,
          ),
        ),
        body: Body());
    // body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

Widget notificationHeader(BuildContext context) {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: [
      Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Text('Notifications', style: TextStyle(fontSize: 20)),
          )),
      Align(
          alignment: Alignment.centerRight,
          child: Container(
              padding: EdgeInsets.only(right: 10.0),
              child: TextButton.icon(
                icon: Icon(Icons.sort),
                label: Text('Sort'),
                onPressed: () {
                  //TODO LIST.sort() then is sorting done;
                },
              )))
    ],
  ));
}

// testing of notif
List<NotifItem> hello = [
  MessageItem('Sender Edan :)', 'Message body is empty!'),
  MessageItem('Sender hello!', 'but really I am still testing only')
];

class _BodyState extends State<Body> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Notification'),
    Tab(text: 'Chat'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            shape: Border(
              top: BorderSide(color: Theme.of(context).canvasColor),
            ),
            bottom: TabBar(
              tabs: myTabs,
              isScrollable: false,
              indicatorWeight: 3.0,
              //TODO OnTap Function
            ),
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
          ),
          body: TabBarView(
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  notificationHeader(context),
                  Container(
                      child: SingleChildScrollView(
                    child: // CHILD 1
                        ListView.builder(
                      //CHILD 2
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      itemCount: hello.length,
                      itemBuilder: (context, index) {
                        final item = hello[index];
                        return Card(
                            child: ListTile(
                          onTap: () {
                            print("Hello");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotificationPage(
                                        messageitem: hello[
                                            index]))); // to go  to notifcation
                          },
                          title: item.buildTitle(context),
                          subtitle: item.buildSubtitle(context),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ));
                      },
                    ),
                  ))
                ],
              ),
              ChatPage(),
            ],
          ),
        ));
  }
}
