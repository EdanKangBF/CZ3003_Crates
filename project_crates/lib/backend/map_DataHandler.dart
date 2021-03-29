import 'dart:io';
import 'dart:math';
import 'package:vector_math/vector_math.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/Listing.dart';

class DataHandler {


  final _databaseRef = FirebaseDatabase.instance.reference();
  final _storageRef = FirebaseStorage.instance.ref();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<dynamic> getImg(String imageType,String imageName) async {
    String url = await FirebaseStorage.instance.ref().child("$imageType/$imageName").getDownloadURL();
    print("url retrieve successfully $url");
    return url;
  }
  //insert current location as argument
  Future<List<Listing>> retrieveUserListing(double latitude, double longitude,  double distance) async {
    List<Listing> userNormalListing = new List<Listing>();
    String url = "";
    await _databaseRef.child("Listing").once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        if(_haversine(latitude, longitude, value['latitude'], value['longitude']) <= distance) {
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
  //insert current location as argument
  Future<List<Listing>> retrieveFilterUserListing(double latitude, double longitude,  double distance, String category) async {
    List<Listing> userNormalListing = new List<Listing>();
    String url = "";
    await _databaseRef.child("Listing").once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        if(value['category'] == category && _haversine(latitude, longitude, value['latitude'], value['longitude']) <= distance) {
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
  //return distance
  double _haversine(double lat1, lon1, lat2, lon2){
    final R = 6372.8; // In kilometers

    double dLat = radians(lat2 - lat1);
    double dLon = radians(lon2 - lon1);
    lat1 = radians(lat1);
    lat2 = radians(lat2);
    double a = pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
    double c = 2 * asin(sqrt(a));
    return R * c;
  }
}
