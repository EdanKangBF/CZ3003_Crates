import 'package:flutter/Material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/backend/profile_presenter.dart';
import 'package:flutter_application_1/models/User.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/backend/auth.dart';

final dbRef = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;

class TestReadScreen extends StatefulWidget {
  @override
  _TestReadScreenState createState() => _TestReadScreenState();
}

class _TestReadScreenState extends State<TestReadScreen> {
  var retrivedData;
  void readData() async {
    var _databaseRef =
        FirebaseDatabase().reference().child('/testwrite/nested');
    _databaseRef.once().then((DataSnapshot data) {
      setState(() {
        retrivedData = data.value;
      });
    });

    print(retrivedData);
  }

  void writeData() async {
    var _firebaseRef = FirebaseDatabase().reference().child('users');
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    dbRef.child('/testwrite/nested').set({'uid': uid});
    dbRef.child('/testwrite/nested2').set({'uid': retrivedData});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen Read Data from Database'),
      ),
      body: Row(
        children: [
          Container(
            child: ElevatedButton(
              onPressed: () {
                readData();
              },
              child: Text('Read Data'),
            ),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () {
                  writeData();
                },
                child: Text("Write Data")),
          )
        ],
      ),
    );
  }
}
