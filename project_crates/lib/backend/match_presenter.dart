import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/models/ListingImageData.dart';
import 'package:flutter_application_1/models/Post.dart';
import 'package:http/http.dart' as http;

class MatchPresenter{

  final _databaseRef = FirebaseDatabase.instance.reference();
  String url = "api.foodai.org";

  Future<List<Post>> fetchCategories(String foodurl) async {
    List<Post> postList = new List<Post>();
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
        Post post = new Post(food_category: categories[i][0], percentage: double.parse(categories[i][1]));
        print(post.food_category);
        print(post.percentage);
        postList.add(post);
      }
    }
    //If no response == 200, means no match
    else{
    }

    return postList;
  }

  Future addListingImageData(ListingImageData data) async{
    await _databaseRef.child("ListingImageData").push().set({
      "listingID": data.listingID,
      "categories": data.categories,
    });
  }
}


