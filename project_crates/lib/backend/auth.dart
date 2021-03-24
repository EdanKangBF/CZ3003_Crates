import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
var _firebaseRef = FirebaseDatabase().reference().child('users');

Future<FirebaseUser> createUserWithEmailAndPassword(email, password) async {
  final FirebaseUser user = (await
  _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  )).user;
  return user;
}

void createUserDetails(userDB, username, email){
  FirebaseUser user = userDB;
  _firebaseRef.child(user.uid).set({
    'userID':  user.uid, //Get from authentication db
    'username': username,
    'email': email,
    'isAdmin': false,
    'imagePath': 'https://firebasestorage.googleapis.com/v0/b/test-firebase-c99c0.appspot.com/o/Profile%2Fimage_picker5856535530717710540.jpg?alt=media&token=4f4985b1-75e2-41b4-acc6-897d6dea7d5c'//default false,
  });
}

Future<FirebaseUser> signInWithEmailAndPassword(email, password) async {
  final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  )).user;
  return user;
}

Future<User> isAdminCheck(userDB) async{
  FirebaseUser user = userDB;
  DataSnapshot snapshot =  await _firebaseRef.child(user.uid).once();
  User _user = new User(userID: user.uid, username: snapshot.value['username'],
      email:snapshot.value['email'], isAdmin: snapshot.value['isAdmin']);
  return _user;
}
