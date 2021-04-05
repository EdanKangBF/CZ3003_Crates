import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';
import '../models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
var _firebaseRef = FirebaseDatabase().reference().child('users');

Future<User> createUserWithEmailAndPassword(email, password) async {
  final User user = (await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  ))
      .user;
  return user;
}

void createUserDetails(userDB, username, email) {
  User user = userDB;
  _firebaseRef.child(user.uid).set({
    'userID': user.uid, //Get from authentication db
    'username': username,
    'email': email,
    'isAdmin': false, //default false,
  });
}

Future<User> signInWithEmailAndPassword(email, password) async {
  final User user = (await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  ))
      .user;
  return user;
}

Future<Users> isAdminCheck(userDB) async {
  User user = userDB;
  DataSnapshot snapshot = await _firebaseRef.child(user.uid).once();
  Users _user = new Users(
      userID: user.uid,
      username: snapshot.value['username'],
      email: snapshot.value['email'],
      isAdmin: snapshot.value['isAdmin']);
  return _user;
}

//TODO Added by EDAN

// Future<String> getCurrentUserUid() async {
//   final FirebaseUser currentUser = await _auth.currentUser();
//   final uid = currentUser.uid;

//   if (uid == null) {
//     return 'null';
//   } else {
//     return uid;
//   }
//   //return uid;
// }
