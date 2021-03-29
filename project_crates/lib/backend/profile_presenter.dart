import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/Listing.dart';
import '../models/Review.dart';
import '../models/user.dart';

class ProfilePresenter{
  static final ProfilePresenter _imagePresenter = ProfilePresenter._internal();

  factory ProfilePresenter() {
    return _imagePresenter;
  }
  // singleton boilerplate
  ProfilePresenter._internal();

  final _databaseRef = FirebaseDatabase.instance.reference();
  final _storageRef = FirebaseStorage.instance.ref();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> retrieveUserProfile(String uid) async {
    DataSnapshot snapshot = await _databaseRef.child("users").child(uid).once();
    String url = await getImg("profileImages", uid);
    User user = new User(username: snapshot.value['username'],email: snapshot.value['email'],image: File(url), isAdmin: false);
    return user;
  }
  Future<void> updateUserProfile(User user) async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    uploadImage(user.image);
    _databaseRef.child('Users').child(currentUser.uid).update({
      'username': user.username,
      'email': user.email,
      'isAdmin': false,

    });

    return;
  }
  Future<void> uploadImage(File image) async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    DataSnapshot snapshot = await _databaseRef.child("users").child(currentUser.uid).once();
    String pastUrl = await _storageRef.child("profileImages/" + snapshot.value['image']).getDownloadURL();
    StorageReference ref = await FirebaseStorage().getReferenceFromUrl(pastUrl);
    ref.delete();

    StorageReference firebaseStorageRef = _storageRef.child("profileImages/").child(currentUser.uid);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    await uploadTask.onComplete;

    return;
  }
  Future<dynamic> getImg(String imageType,String imageName) async {
    String url = await FirebaseStorage.instance.ref().child("$imageType/$imageName").getDownloadURL();
    print("url retrieve successfully $url");
    return url;
  }

  Future<void> retrieveUserListing(String uid) async {
    List<Listing> userNormalListing = new List<Listing>();
    String url = "";
    await _databaseRef.child("Listing").once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        if(value['isRequest']== false && value['userID'] == uid){
          url = getImg("normalListings", snapshot.key).toString();
          Listing normalListing = new Listing(listingID: snapshot.key,listingTitle: value['listingTitle'],category: value['category']
              ,postDateTime: value['postDateTime'],description: value['description'],isRequest: value['isRequest'],
              listingImage: File(url),longitude: value['longitude'],latitude:value['latitude'] );
          userNormalListing.add(normalListing);
        }
      });
    });

    return userNormalListing;
  }

  Future<List<Listing>> retrieveUserRequestListing(String uid) async {
    List<Listing> userRequestListing = new List<Listing>();
    String url = "";
    await _databaseRef.child("Listing").once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        if(value['isRequest']== true && value['userID'] == uid){
          url = getImg("normalListings", snapshot.key).toString();
          Listing normalListing = new Listing(listingID: snapshot.key,listingTitle: value['listingTitle'],category: value['category']
              ,postDateTime: value['postDateTime'],description: value['description'],isRequest: value['isRequest'],
              listingImage: File(url),longitude: value['longitude'],latitude:value['latitude'] );
          userRequestListing.add(normalListing);
        }
      });
    });
    return userRequestListing;
  }
  Future<int> reviewCounts(String uid) async {
    int reviewCount = 0;
    await _databaseRef.child("Review").once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        if(value['revieweeID'] == uid){
          reviewCount++;
        }
      });
    });
    return reviewCount;
  }
  Future<List<Review>> reviewList(String uid) async {
    List<Review> reviewList = new List<Review>();
    await _databaseRef.child("Review").once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        if(value['revieweeID'] == uid){
          Review review = new Review(rating: value['rating'],description: value['description'], listingID: value['listingID'],
          revieweeID: value['revieweeID'], reviewerID: value['reviewerID'], reviewTitle: value['reviewTitle']);
          reviewList.add(review);
        }
      });
    });
    return reviewList;
  }
}