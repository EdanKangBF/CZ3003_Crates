import 'package:firebase_database/firebase_database.dart';
// import 'landingPage.dart';

// final databaseReference = FirebaseDatabase.instance.reference();

// //ADDING DATA TO DATABASE
// DatabaseReference savePost(LandingPage post) {
//   var id = databaseReference.child('testchild/').push();
//   id.set({});
// }
final userDatabaseReference =
    FirebaseDatabase.instance.reference().child('/users');

final DatabaseReference _messageDatabaseReferrence =
    FirebaseDatabase.instance.reference().child('messages');

class DatabaseMethods {
  addUserInfoToDB(String userID, userEmail, userName) {
    userDatabaseReference.push().set({
      'id': userID,
      'email': userEmail,
      'username': userName,
    });
  }

  getUserByUserName(String username) async {
    return userDatabaseReference.orderByChild('username').equalTo(username);
  }
}
