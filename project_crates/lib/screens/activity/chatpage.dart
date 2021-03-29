import 'package:flutter/material.dart';
import '../activity/items.dart';
import '../activity/activity.dart';
import '../activity/notificationpage.dart';

class ChatPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          chatHeader(),
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
                  leading:
                      FlutterLogo(), //  TODO how to change to profile picture
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ChattingPage(
                    //             //TODO change to chatpage
                    //             messageitem:
                    //                 hello[index]))); // to go  to notifcation
                  },
                  title: item.buildTitle(context),
                  subtitle: item.buildSubtitle(context),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  isThreeLine: true,
                ));
              },
            ),
          ))
        ],
      ),
    );
  }
}

// create chat header
Widget chatHeader() {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: [
      //search bar
      Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Text('Chat', style: TextStyle(fontSize: 20)),
          )),
      Align(
          alignment: Alignment.centerRight,
          child: Container(
              padding: EdgeInsets.only(right: 10.0),
              child: TextButton.icon(
                icon: Icon(Icons.sort),
                label: Text('Sort'),
                onPressed: () {},
              )))
    ],
  ));
}

//TODO wait for egg stuff
// class ChattingPage extends StatelessWidget {
//   final MessageItem messageitem;

//   ChattingPage({Key key, @required this.messageitem}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: false,
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.amber[400],
//           leading: Builder(builder: (BuildContext context) {
//             return IconButton(
//                 icon: const Icon(Icons.keyboard_backspace), // need to change
//                 onPressed: () {
//                   Navigator.pop(context);
//                 });
//           }),
//           title: Text("Name of Person",
//               style: TextStyle(fontSize: 30, color: Colors.white)),
//           shape: RoundedRectangleBorder(
//               borderRadius:
//                   BorderRadius.vertical(bottom: Radius.circular(40.0))),
//         ),
//         body: Column(children: <Widget>[
//           Text('Name of the dude'),
//           secondRow(),
//           chat(),
//           enterMessage(),
//         ]));
//   }
// }

// Widget secondRow() {
//   return Container(
//     child: Expanded(
//       child: Row(children: <Widget>[
//         Text('<3'),
//         Column(children: <Widget>[
//           Center(child: Text('Listing name')),
//           Center(
//               child:
//                   TextButton(onPressed: () {}, child: Text('COmplete Listing')))
//         ]),
//         Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
//           Text('empty to align????'),
//           TextButton(
//             onPressed: () {},
//             child: Text('Leave Review'),
//           )
//         ])
//       ]),
//     ),
//   );
// }

// Widget chat() {
//   return Container(child: Text('just chatting'));
// }

// Widget enterMessage() {
//   return Container(
//     child: Column(children: [
//       TextField(
//         decoration: InputDecoration(labelText: 'Message'),
//       ),
//       IconButton(
//           icon: const Icon(Icons.attach_file),
//           onPressed: () {}) //TODO ATTACH FILE
//     ]),
//   );
// }
