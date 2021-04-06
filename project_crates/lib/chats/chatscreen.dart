import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/chats/chatmessage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

const String _title = 'chat screen';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key, this.currentUserId, this.chatUserId}) : super(key: key);

  final String currentUserId;
  final String chatUserId;
  @override
  State createState() => ChatScreenState(_title, currentUserId, chatUserId);
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final String _currentUserId;
  final String _chatUserId;
  final _title;
  final List<ChatMessage> _messages;
  final TextEditingController _textController;
  final DatabaseReference _messageDatabaseReference;
  final StorageReference _photoStorageReference;
  final DatabaseReference _userDatabaseReference;
  String _chatRoomId;
  List lists = [];
  String username = '';

  bool _isComposing = false;

  ChatScreenState(String title, String currentUserId, String chatUserId)
      : _title = title,
        _chatUserId = chatUserId,
        _currentUserId = currentUserId,
        _isComposing = false,
        _messages = <ChatMessage>[],
        _textController = TextEditingController(),
        _userDatabaseReference =
            FirebaseDatabase.instance.reference().child('users'),
        _messageDatabaseReference =
            FirebaseDatabase.instance.reference().child('messages'),
        _photoStorageReference =
            FirebaseStorage.instance.ref().child('chat_photos') {
    _messageDatabaseReference.onChildAdded.listen(_onMessageAdded);
  }
  @override
  void initState() {
    super.initState();
    getUsername();
    _chatRoomId = _currentUserId + _chatUserId;
  }

  void getUsername() async {
    await _userDatabaseReference
        .orderByKey()
        .equalTo(_currentUserId)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      print(values.toString());
      values.forEach((key, values) {
        lists.add(values['username']);
        setState(() {
          username = values['username'].toString();
        });
      });
    });
  }

  Widget _buildTextComposer(BuildContext context) {
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
    final text = event.snapshot.value['text'];
    final imageUrl = event.snapshot.value['imageUrl'];

    ChatMessage message = imageUrl == null
        ? _createMessageFromText(text)
        : _createMessageFromImage(imageUrl);

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

    final ChatMessage message = _createMessageFromText(text);
    _messageDatabaseReference.child(_chatRoomId).push().set(message.toMap());
  }

  void _sendImage(ImageSource imageSource) async {
    File image = await ImagePicker.pickImage(source: imageSource);
    final String fileName = Uuid().v4();
    StorageReference photoRef = _photoStorageReference.child(fileName);
    final StorageUploadTask uploadTask = photoRef.putFile(image);
    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    final ChatMessage message = _createMessageFromImage(
      await downloadUrl.ref.getDownloadURL(),
    );
    _messageDatabaseReference.child(_chatRoomId).push().set(message.toMap());
  }

  void _sendImageFromCamera() async {
    _sendImage(ImageSource.camera);
  }

  void _sendImageFromGallery() async {
    _sendImage(ImageSource.gallery);
  }

  ChatMessage _createMessageFromText(String text) => ChatMessage(
        text: text,
        username: username,
        currentUserId: _currentUserId,
        chatUserId: _chatUserId,
        animationController: AnimationController(
          duration: Duration(milliseconds: 180),
          vsync: this,
        ),
      );

  ChatMessage _createMessageFromImage(String imageUrl) => ChatMessage(
        imageUrl: imageUrl,
        username: username,
        currentUserId: _currentUserId,
        chatUserId: _chatUserId,
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
              child: _buildTextComposer(context),
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
