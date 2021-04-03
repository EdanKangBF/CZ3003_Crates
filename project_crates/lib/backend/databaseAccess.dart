import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/backend/storageAccess.dart';
import 'package:flutter_application_1/models/Listing.dart';

class DatabaseAccess {
  final databaseRef = FirebaseDatabase.instance.reference();
  StorageAccess storageAccess = StorageAccess();

  //add a listing to firebase database, returns the unique key identifier of the created node as a String
  Future<String> addListing(Listing newListing) async {
    DatabaseReference pushedPostRef = databaseRef.child('Listing').push();
    String postKey = pushedPostRef.key;
    await pushedPostRef.set({
      "isRequest": newListing.isRequest,
      "category": newListing.category,
      "listingTitle": newListing.listingTitle,
      "description": newListing.description,
      "latitude": newListing.latitude,
      "longitude": newListing.longitude,
      "listingImage": newListing.listingImage,
      "postDateTime": DateTime.now().toIso8601String(),
      "userID": newListing.userID,
      "isComplete": false,
    });
    print('Created postKey: $postKey');
    return postKey;
  }

  Future<Listing> getListing(String key) async {
    Listing listing;
    await databaseRef
        .child('Listing')
        .orderByKey()
        .equalTo(key)
        .once()
        .then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> data = snapshot.value;
      Map listingData = data[key];
      listing = Listing(
        category: listingData['category'],
        isRequest: listingData['isRequest'],
        listingImage: listingData['listingImage'],
        latitude: listingData['latitude'],
        listingTitle: listingData['listingTitle'],
        description: listingData['description'],
        postDateTime: DateTime.parse(listingData['postDateTime']),
        userID: listingData['userID'],
        longitude: listingData['longitude'],
        isComplete: listingData['isComplete'],
      );
    });
    return listing;
  }

  //to access an individual listing, use list[index].attributeName
  Future<List<Listing>> retrieveAllListings() async {
    List<Listing> list = [];
    DatabaseReference ref = databaseRef.child('Listing');
    await ref.once().then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> data = snapshot.value;
      for (var entry in data.entries) {
        Listing listing = await getListing(entry.key);
        list.add(listing);
      }
    });
    return list;
  }

  Stream retrieveListingStream() {
    Stream stream = databaseRef.child("Listing").onValue;
    return stream;
  }

  //delete listing node using its unique key
  void deleteListingOnKey(String key) async {
    DatabaseReference entryRef = databaseRef.child("Listing").child(key);

    //delete image from storage if it exists
    await entryRef.once().then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> data = snapshot.value;
      if (data['listingImage'] != null) {
        await storageAccess.deleteListingImage(data['listingImage']);
      }
    });

    //after storage deletion, delete database entry
    try {
      await databaseRef.child('Listing').child(key).remove();
      print('Listing deleted from listing model');
    } catch (e) {
      print('Listing Deletion unsuccessful');
      print(e);
    }


  }

  //update an entire listing node with a new listing, postDateTime updated to DateTime.now()
  void updateListing(String existingListingID, Listing updatedListing) async {
    Map<String, dynamic> map = {
      'isRequest': updatedListing.isRequest,
      'category': updatedListing.category,
      'listingTitle': updatedListing.listingTitle,
      'description': updatedListing.description,
      'latitude': updatedListing.latitude,
      'longitude': updatedListing.longitude,
      'listingImage': updatedListing.listingImage,
      'postDateTime': DateTime.now().toIso8601String(),
      'userID': updatedListing.userID,
      'isComplete': false,
    };

    databaseRef.child("Listing").child(existingListingID).set(map);
  }
  void markListingAsComplete(String listingID) async{
    await databaseRef.child("Listing").child(listingID).update({
      "isComplete": true
    });
  }
}
