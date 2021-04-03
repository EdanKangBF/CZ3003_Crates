import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/models/Listing.dart';
import 'package:flutter_application_1/models/ListingImageData.dart';
import 'package:http/http.dart' as http;

class MatchPresenter {
  final _databaseRef = FirebaseDatabase.instance.reference();
  String url = "api.foodai.org";

  Future<Map<String, double>> fetchCategories(String foodurl) async {
    Map map = Map<String, double>();
    final response = await http.post(
      Uri.https('api.foodai.org', 'v1/classify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "image_url": foodurl,
        "num_tag": '3',
        "api_key": 'c8d4e2ec8f5190f923de53e5d47972a698ce7054',
      }),
    );

    if (response.statusCode == 200) {
      //print(response.body);
      var responseJson = json.decode(response.body);
      var categories = responseJson['food_results_by_category'];
      var length = responseJson['food_results_by_category'].length;

      for (int i = 0; i < length; i++) {
        var weight = double.parse(categories[i][1]);
        // don't store if the weight is not at least 0.7
        if (weight >= 0.7) {
          map[categories[i][0]] = weight;
        }
      }
    }
    //If no response == 200, means no match
    else {}

    return map;
  }

  Future addListingImageData(ListingImageData data) async {
    await _databaseRef.child("ListingImageData").push().set({
      "listingID": data.listingID,
      "categories": data.categories,
    });
  }

  Future<List<String>> getMatchedListingIDs(
      Map<String, double> categories) async {
    // to store all LIDs
    var listingImageDataList = [];

    // list of listings IDs that has common classifications
    var results = <String>[];

    // retrieve all ListingImageData from db
    try {
      await _databaseRef
          .child('ListingImageData')
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> map = snapshot.value;
        map.forEach((key, value) {
          var lid = ListingImageData(
            listingID: value['listingID'],
            categories: Map.from(value['categories']),
          );
          listingImageDataList.add(lid);
        });
      });
      print(
          'Retrieved ${listingImageDataList.length} listingImageData (LIDs) from db!');
    } catch (e) {
      print(e);
      print(
          'getMatchedListings(): Error occurred retrieving ListingImageData model');
      return null;
    }
    ;

    // sort
    var sortedCategories = categories.keys.toList()
      ..sort((a, b) => categories[b].compareTo(categories[a]));

    // loop through each category
    sortedCategories.forEach((key) {
      listingImageDataList.forEach((lid) {
        if (lid.categories.containsKey(key)) {
          results.add(lid.listingID);
        }
      });
    });
    print('Matched ${results.length} LIDS');
    return results;
  }

  // query the db for listings that match
  Future<List<Listing>> getMatchedListings(List<String> matchedListingIDs) async {
    // list of listings to store the result
    var matchedListings = <Listing>[];

    // retrieves all listings, and do matching
    try {
      await _databaseRef
          .child('Listing')
          .orderByChild('postDateTime')
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> map = snapshot.value;

        for (dynamic key in map.keys){
          var value = map[key];

          // if listing is not complete, and it's ID is in the matchedListingIDs list
          if (value['isComplete'] == false && matchedListingIDs.contains(key)) {
            // construct Listing object
            var match = Listing(
                listingID: key,
                userID: value['userID'],
                listingTitle: value['listingTitle'],
                category: value['category'],
                postDateTime: DateTime.parse(value['postDateTime']),
                description: value['description'],
                isRequest: value['isRequest'],
                isComplete: value['isComplete'],
                listingImage: value['listingImage'],
                longitude: value['longitude'],
                latitude: value['latitude']);

            // append to results list
            matchedListings.add(match);

            // if 3 already found, break early
            if (matchedListings.length >= 3){
              break;
            }

          }
        }
      });
    } catch (e) {
      print('getMatchedListings(): Error occurred retrieving matches');
    }
    ;
    print('Matched: ${matchedListings.length} listings');
    return matchedListings;
  }

  Future<List<Listing>> getMatches(Map<String, double> classifications) async{
    var matchedListingsID = await getMatchedListingIDs(classifications);

    if (matchedListingsID.isEmpty){
      return null;
    }

    var matchedListings = await getMatchedListings(matchedListingsID);

    if (matchedListings.isEmpty){
      return null;
    }

    return matchedListings;
  }


}
