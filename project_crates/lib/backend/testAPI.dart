import 'dart:convert';

import 'package:flutter_application_1/models/Post.dart';
import 'package:http/http.dart' as http;

String url = "api.foodai.org";
String foodurl = "https://firebasestorage.googleapis.com/v0/b/test-firebase-c99c0.appspot.com/o/Listing%2Fa0a036b9-591d-4e59-a1da-d1201407ade120210303_141005.jpg?alt=media&token=77c7b227-079f-4985-b376-7e68b5728cef";

String foodurl2 = "https://www.google.com/search?q=coffee+packet&rlz=1C1CHBF_enSG865SG865&sxsrf=ALeKk02OGZ-6MV7RG9cj9YBC84w_oEtcBA:1617435361030&source=lnms&tbm=isch&sa=X&ved=2ahUKEwitjJChyOHvAhWg63MBHVTXDG8Q_AUoAXoECAIQAw&biw=1536&bih=698&dpr=1.25#imgrc=mPm5V2ftcL03_M";
String foodurl3 = "http://blog-imgs-24.fc2.com/k/u/i/kuimakuru/20080525_5s.jpg";

Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

Future<Post> fetchMatch() async {
  final response = await http.post(
    Uri.https('api.foodai.org', 'v1/classify'),
    body: jsonEncode(<String, String>{
      "image_url": "http://blog-imgs-24.fc2.com/k/u/i/kuimakuru/20080525_5s.jpg",
      "num_tag": '3',
      "api_key": 'c8d4e2ec8f5190f923de53e5d47972a698ce7054',
    }),
    );

  print(response.statusCode);
  if(response.statusCode == 200){
    print("test");
    //return Post.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception("No match found");
  }
}

Future<http.Response> createAlbum(String title) {
  return http.post(
    Uri.https('jsonplaceholder.typicode.com', 'albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
}
