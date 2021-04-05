import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Chat/chatmessage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

//const String _name = "maybe";
const String _title = 'chat screen';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key, this.currentUserId, this.chatUserId}) : super(key: key);

  final String currentUserId;
  final String chatUserId;

  @override
  State createState() => _ChatScreenState(_title, chatUserId, currentUserId);
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final String _chatUserId;
  final String _currentUserId;
  //final String _username;
  final _title;
  final List<ChatMessage> _messages;
  final TextEditingController _textController;
  final DatabaseReference _messageDatabaseReference;
  final StorageReference _photoStorageReference;
  String _combinedId;
  final DatabaseReference _userDatabaseReference;
  bool _isComposing = false;
  String username = '';
  List lists = [];

  _ChatScreenState(String title, String chatUserId, String currentUserId)
      : _title = title,
        _combinedId = chatUserId + currentUserId,
        _chatUserId = chatUserId,
        _currentUserId = currentUserId,
        _isComposing = false,
        _messages = <ChatMessage>[],
        _textController = TextEditingController(),
        _userDatabaseReference =
            FirebaseDatabase.instance.reference().child("users"),
        _messageDatabaseReference =
            FirebaseDatabase.instance.reference().child("messages"),
        _photoStorageReference =
            FirebaseStorage.instance.ref().child("chat_photos") {
    _messageDatabaseReference
        .child(_combinedId)
        .onChildAdded
        .listen(_onMessageAdded);
  }
  @override
  void initState() {
    super.initState();
    getUsername();
  }

  Future<void> getUsername() async {
    _userDatabaseReference
        .orderByKey()
        .equalTo(_currentUserId)
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
        print(lists[0]);
        setState(() {
          username = values["username"].toString();
        });
      });
    });
  }

  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textController,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: _handleSubmitted,
                  decoration:
                      InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: _sendImageFromCamera,
                      ),
                      IconButton(
                        icon: Icon(Icons.image),
                        onPressed: _sendImageFromGallery,
                      ),
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? CupertinoButton(
                              child: Text("Send"),
                              onPressed: _isComposing
                                  ? () => _handleSubmitted(_textController.text)
                                  : null,
                            )
                          : IconButton(
                              icon: Icon(Icons.send),
                              onPressed: _isComposing
                                  ? () => _handleSubmitted(_textController.text)
                                  : null,
                            ),
                    ],
                  ))
            ],
          ),
        ));
  }

  void _onMessageAdded(Event event) {
    final text = event.snapshot.value["text"];
    final imageUrl = event.snapshot.value["imageUrl"];

    ChatMessage message = imageUrl == null
        ? _createMessageFromText(text, _chatUserId, _currentUserId, username)
        : _createMessageFromImage(
            imageUrl, _chatUserId, _currentUserId, username);

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    print("Username: " + username);

    final ChatMessage message =
        _createMessageFromText(text, _chatUserId, _currentUserId, username);
    _messageDatabaseReference.child(_combinedId).push().set(message.toMap());
  }

  void _sendImage(ImageSource imageSource) async {
    File image = await ImagePicker.pickImage(source: imageSource);
    final String fileName = Uuid().v4();
    StorageReference photoRef = _photoStorageReference.child(fileName);
    final StorageUploadTask uploadTask = photoRef.putFile(image);
    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    final ChatMessage message = _createMessageFromImage(
        await downloadUrl.ref.getDownloadURL(),
        _chatUserId,
        _currentUserId,
        username);
    _messageDatabaseReference.child(_combinedId).push().set(message.toMap());
  }

  void _sendImageFromCamera() async {
    _sendImage(ImageSource.camera);
  }

  void _sendImageFromGallery() async {
    _sendImage(ImageSource.gallery);
  }

  ChatMessage _createMessageFromText(String text, String chatUserId,
          String currentUserId, String username) =>
      ChatMessage(
        text: text,
        username: username,
        chatUserId: chatUserId,
        currentUserId: currentUserId,
        animationController: AnimationController(
          duration: Duration(milliseconds: 180),
          vsync: this,
        ),
      );

  ChatMessage _createMessageFromImage(String imageUrl, String chatUserId,
          String currentUserId, String username) =>
      ChatMessage(
        imageUrl: imageUrl,
        chatUserId: chatUserId,
        currentUserId: currentUserId,
        username: username,
        animationController: AnimationController(
          duration: Duration(milliseconds: 90),
          vsync: this,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                top: BorderSide(color: Colors.grey[200]),
              ))
            : null,
      ),
    );
  }
}
