import 'package:firebase_database/firebase_database.dart';
import 'landingPage.dart';

final databaseReference = FirebaseDatabase.instance.reference();

//ADDING DATA TO DATABASE
DatabaseReference savePost(LandingPage post) {
  var id = databaseReference.child('testchild/').push();
  id.set({});
}
