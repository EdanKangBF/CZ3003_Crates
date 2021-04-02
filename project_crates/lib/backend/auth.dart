import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/authenticate/root.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
var _firebaseRef = FirebaseDatabase().reference().child('users');

// Display Login Successful/Unsuccessful
displayToastMessage(String message, BuildContext context){
  Fluttertoast.showToast(msg: message);
}

// For Register Page
Future<FirebaseUser> createUserWithEmailAndPassword(email, password, context) async {
  final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(email: email, password: password,)).user;
  if (user!=null){
    print('Registered: ${user.uid}');
    displayToastMessage("Account Created Successfully", context);
  }
  return user;
}

void createUserDetails(userDB, username, email){
  FirebaseUser user = userDB;
  _firebaseRef.child(user.uid).set({
    'userID':  user.uid, //Get from authentication db
    'username': username,
    'email': email,
    'isAdmin': false, //default false,
    'isBanned': '0', //default false
    'imagePath': 'https://firebasestorage.googleapis.com/v0/b/test-firebase-c99c0.appspot.com/o/Profile%2Fimage_picker5856535530717710540.jpg?alt=media&token=4f4985b1-75e2-41b4-acc6-897d6dea7d5c'//default path
  });
}

// For Sign In Page
Future<FirebaseUser> signInWithEmailAndPassword(email, password) async {
  try {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: email, password: password,)).user;
    print('Signed in: ${user.uid}');

    return user;
  }
  catch(e){
    print('Error: $e');
    return null;
  }
}

Future<bool> isAdminCheck(userID) async{
  DataSnapshot snapshot =  await _firebaseRef.child(userID).once();
  return snapshot.value['isAdmin'];
}

Future<String> isBannedCheck(userID) async{
  DataSnapshot snapshot =  await _firebaseRef.child(userID).once();
  return snapshot.value['isBanned'];
}

// Get Current Login UserID
Future<String> currentUser() async {
  FirebaseUser user = await _auth.currentUser();
  return user.uid;
}

//For Sign Out Button
Future<void> signOut(context) async {
  await _auth.signOut();
  displayToastMessage('Logout Successful', context);
  await Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => RootPage())
  );
}
