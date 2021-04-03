import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/models/Listing.dart';
import 'package:flutter_application_1/models/ListingImageData.dart';
import 'package:http/http.dart' as http;

class MatchPresenter{

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

    if(response.statusCode == 200){
      //print(response.body);
      var responseJson = json.decode(response.body);
      var categories = responseJson['food_results_by_category'];
      var length = responseJson['food_results_by_category'].length;

      for(int i = 0; i < length; i++){
        map[categories[i][0]] = double.parse(categories[i][1]);
      }
    }
    //If no response == 200, means no match
    else{
    }

    return map;
  }

  Future addListingImageData(ListingImageData data) async{
    await _databaseRef.child("ListingImageData").push().set({
      "listingID": data.listingID,
      "categories": data.categories,
    });
  }


  Future<List<String>> getMatchedListingIDs(List<String> categories) async{
    // list of listings IDs that has common classifications
    var matchedListingIDs = [];

    // retrieve a list of listing IDs that has common classifications
    try{
      await _databaseRef.child('ListingImageData').once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> map = snapshot.value;
        map.forEach((key, value) {
          // at least one common classification category
          if (categories.any((item) => value['categories'].contains(item))) {
            matchedListingIDs.add(value['listingID']);
          }
        });
      });
      print('Listing IDs that matched classification category "$categories": $matchedListingIDs');
    }catch(e){
      print('getMatchedListings(): Error occurred retrieving ListingImageData model');
    };

    return matchedListingIDs;
  }


  // query the db for listings that match
  Future<List<Listing>> getMatchedListings(List<String> matchedListingIDs) async {
    // list of listings to store the result
    var matchedListings = [];
    // retrieves all listings, and do matching
    try{
      await _databaseRef.child('Listing').orderByChild('postDateTime').once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> map = snapshot.value;
        map.forEach((key, value) {

          // if listing is not complete, and it's ID is in the matchedListingIDs list
          if (value['isComplete'] == false && matchedListings.contains(key)){

            // construct Listing object
            var match = Listing(
                listingID: key,
                userID : value['userID'],
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
          }
          });
        });
    }catch(e){
      print('getMatchedListings(): Error occurred retrieving matches');
    };
    print('Matched: ${matchedListings.length} listings');
    return matchedListings;
  }

}


