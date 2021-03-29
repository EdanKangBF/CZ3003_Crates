import 'package:flutter/Material.dart';
import 'package:firebase_database/firebase_database.dart';

final dbRef = FirebaseDatabase.instance.reference();

class TestReadScreen extends StatefulWidget {
  @override
  _TestReadScreenState createState() => _TestReadScreenState();
}

class _TestReadScreenState extends State<TestReadScreen> {
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
              onPressed: () {},
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

void readData() {
  print(dbRef.once().then((value) => value));
}

void writeData() {
  dbRef.child('/testwrite/nested').set({'id': 'ID1', 'data': 'Sample Data'});
}
