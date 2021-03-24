import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/backend/profile_presenter.dart';
import '../models/user.dart';

class AuthService{
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
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<User> isAdminCheck(userDB) async{
    FirebaseUser user = userDB;
    DataSnapshot snapshot =  await _firebaseRef.child(user.uid).once();
    User _user = new User(userID: user.uid, username: snapshot.value['username'],
        email:snapshot.value['email'], isAdmin: snapshot.value['isAdmin']);
    return _user;
  }

  // steam for user auth change, will trigger wrapper to be rebuilt
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
    //     .map(_userFromFirebaseUser);
  }

  // for user sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}

