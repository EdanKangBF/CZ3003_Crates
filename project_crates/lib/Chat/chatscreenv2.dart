// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_application_1/Chat/chatmessage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:uuid/uuid.dart';
// import 'dart:convert';

// const _name = 'name';

// class ChatScreen extends StatefulWidget {
//   final currentUserId;
//   final chatUserId;

//   ChatScreen({Key key, this.currentUserId, this.chatUserId}) : super(key: key);

//   //convert currentUserId from dynamic to string
//   Map<String, dynamic> convertString() => {'currentUserId': currentUserId};



//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
//   final currentUserId;
//   final chatUserId;

//   final List<ChatMessage> _messages;
//   final TextEditingController _textController;
//   final DatabaseReference _messageDatabaseReference;
//   final StorageReference _photoStorageReference;
//   bool _isComposing = false;
//   final DatabaseReference _userDatabaseReference;

//   //----------------------------------
//   // testing() {
//   //   DatabaseReference _refTest;
//   //   var chatUserName = _refTest.orderByChild('userID').equalTo(chatUserId);
//   //   return;
//   // }

//   //----------------------------------
//   _ChatScreenState({Key key, this.currentUserId, this.chatUserId})
//       : _isComposing = false, //set composing to false
//         _messages = <ChatMessage>[], // store messages in list
//         _textController = TextEditingController(), //instainiate text controller
//         _messageDatabaseReference =
//             FirebaseDatabase.instance.reference().child('testmessage'),
//         _userDatabaseReference = FirebaseDatabase.instance
//             .reference()
//             .child('users') //reference database for messages
//         ,
//         _photoStorageReference =
//             FirebaseStorage.instance.ref().child('chatphotos') {
//     _messageDatabaseReference.onChildAdded.listen((_onMessageAdded));
//   }

//   Widget _buildTextComposer() {
//     return IconTheme(
//         data: IconThemeData(color: Theme.of(context).accentColor),
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 8),
//           child: Row(
//             children: <Widget>[
//               Flexible(
//                 child: TextField(
//                   controller: _textController,
//                   onChanged: (String text) {
//                     setState(() {
//                       _isComposing = text.length > 0;
//                     });
//                   },
//                   onSubmitted: _handleSubmitted,
//                   decoration:
//                       InputDecoration.collapsed(hintText: 'send a message'),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                 child: Row(
//                   children: <Widget>[
//                     IconButton(
//                         icon: Icon(Icons.camera_alt),
//                         onPressed: _sendImageFromCamera),
//                     IconButton(
//                         icon: Icon(Icons.image),
//                         onPressed: _sendImageFromGallery),
//                     //show send button only if _isComposing = true
//                     IconButton(
//                         icon: Icon(Icons.send),
//                         onPressed: _isComposing
//                             ? () => _handleSubmitted(_textController.text)
//                             : null)
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ));
//   }

//   void _handleSubmitted(String text) {
//     _textController.clear();
//     setState(() {
//       _isComposing = false;
//     });

//     final ChatMessage message = _createMessageFromText(text, currentUserId);
//     _messageDatabaseReference.push().set(message.toMap());
//   }

//   void _onMessageAdded(Event event) {
//     final text = event.snapshot.value["text"];
//     final imageUrl = event.snapshot.value["imageUrl"];
//     final userid = event.snapshot.value['userID'];

//     ChatMessage message =
//         imageUrl == null ? _createMessageFromText(text, userid) : null;
//   }

//   ChatMessage _createMessageFromText(String text, String userid) => ChatMessage(
//         text: text,
//         username: _name,
//         userId: userid,
//         animationController: AnimationController(
//           duration: Duration(milliseconds: 180),
//           vsync: this,
//         ),
//       );

//   // void _sendImage(ImageSource imageSource) async {
//   //   File image = await ImagePicker.pickImage(source: imageSource);
//   //   final String fileName = Uuid().v4();
//   //   StorageReference photoRef = _photoStorageReference.child(fileName);
//   //   final StorageUploadTask uploadTask = photoRef.putFile(image);
//   //   final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
//   //   final ChatMessage message = _createMessageFromImage(
//   //     await downloadUrl.ref.getDownloadURL(),
//   //   );
//   //   _messageDatabaseReference.push().set(message.toMap());
//   // }

//   void _sendImageFromCamera() async {}

//   void _sendImageFromGallery() {}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chat Screen')),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Flexible(
//               child: ListView.builder(
//                 padding: EdgeInsets.all(8.0),
//                 reverse: true,
//                 itemBuilder: (_, int index) => _messages[index],
//                 itemCount: _messages.length,
//               ),
//             ),
//             Divider(height: 1.0),
//             Container(
//               decoration: BoxDecoration(color: Theme.of(context).cardColor),
//               child: _buildTextComposer(),
//             ),
//           ],
//         ),
//         decoration: Theme.of(context).platform == TargetPlatform.iOS
//             ? BoxDecoration(
//                 border: Border(
//                 top: BorderSide(color: Colors.grey[200]),
//               ))
//             : null,
//       ),
//     );
//   }
// }
