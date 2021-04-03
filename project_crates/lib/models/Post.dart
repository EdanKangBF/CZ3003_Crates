import 'dart:convert';

// Post postFromJson(String str) {
//   final jsonData = json.decode(str);
//   return Post.fromJson(jsonData);
// }
//
// String postToJson(Post data) {
//   final dyn = data.toJson();
//   return json.encode(dyn);
// }

class Post {
  int status_code;
  int imgid;
  String qid;
  String status_msg;
  List<List<String>> food_results;
  String apiKey;

  Post({
    this.status_code,
    this.imgid,
    this.qid,
    this.status_msg,
    this.food_results,
    this.apiKey
  });

  factory Post.fromJson(Map<String, dynamic> json) => new Post(
    status_code: json["status_code"],
    imgid: json["imgid"],
    qid: json["qid"],
    status_msg: json["status_msg"],
    food_results: json["status_code"]
  );

  Map<String, dynamic> toJson() => {
    "status_code": status_code,
    "imgid": imgid,
    "qid": qid,
    "status_msg": status_msg,
    "status_code" : status_code
  };
}