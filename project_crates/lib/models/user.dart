import 'dart:io';

class User {
  final String userID;
  final String username;
  final String email;
  final bool isAdmin;
  final String imagePath;

  User({this.userID, this.username, this.email, this.isAdmin, this.imagePath});
//User({this.username,this.email,this.isAdmin,this.image});
  User.fromData(Map<String, dynamic> data)
      : userID = data['userID'],
        username = data['username '],
        email = data['email'],
        isAdmin = data['isAdmin'],
        imagePath = data['imagePath'];
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'username': username,
      'email': email,
      'isAdmin': isAdmin,
      'image' : imagePath
    };
  }
}