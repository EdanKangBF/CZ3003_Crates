import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_application_1/backend/auth.dart';
import '../moderator/moderatornavigationBar.dart';
import '../common/widgets.dart';
import '../common/theme.dart';

class Home extends StatefulWidget {
  //Signed Out
  //Home({this.onSignedOut});
  //final VoidCallback onSignedOut;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Sign Out: onPressed: _signOut
/*  void _signOut() async {
    try {
      await signOut();
      widget.onSignedOut();
    }catch(e){
      print(e);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ModeratorNavigationBar(0),
        backgroundColor: offWhite,
        body: ListView(children: <Widget>[
          topCard(),
          SizedBox(height: 15),
          Row(
            children: [
              Container(
                width: 150,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 0, 10),
                  child: filterbutton(),
                ),
              ),
              Container(
                width: 150,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 10),
                    child: sortbutton()),
              ),
            ],
          ),
          NearbyList(),
          SizedBox(height: 30),
        ]));
  }
}

Widget topCard() {
  return Stack(clipBehavior: Clip.none, children: <Widget>[
    Container(
      width: double.infinity,
      height: 80,
      child: Card(
          margin: EdgeInsets.zero,
          color: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.zero,
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          )),
    ),
    Positioned(
      right: 45,
      left: 45,
      bottom: 10,
      child: Container(
        height: 50,
        child: TextField(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                prefixIcon: Icon(Icons.search),
                prefixStyle: TextStyle(
                  decorationColor: Colors.red,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'search')),
      ),
    ),
  ]);
}

Widget NearbyList() {
  // TODO: this is hardcoded data, to remove
  List<ListingCard> listing_list = [
    ListingCard(
        title: "Old Town White Coffee",
        owner: "leejunwei",
        listingImg: 'assets/coffee.jpg',
        ownerImg: 'assets/icons/default.png'),
    ListingCard(
        title: "Korean Spicy Noodles Samyang",
        owner: "Eggxactly",
        listingImg: 'assets/noodles.jpg',
        ownerImg: 'assets/icons/default.png'),
    ListingCard(
        title: "Old Town White Coffee",
        owner: "leejunwei",
        listingImg: 'assets/coffee.jpg',
        ownerImg: 'assets/icons/default.png'),
    ListingCard(
        title: "Korean Spicy Noodles Samyang",
        owner: "Eggxactly",
        listingImg: 'assets/noodles.jpg',
        ownerImg: 'assets/icons/default.png'),
    ListingCard(
        title: "Korean Spicy Noodles Samyang",
        owner: "Eggxactly",
        listingImg: 'assets/noodles.jpg',
        ownerImg: 'assets/icons/default.png')
  ];

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      // TODO for backend person: modify here to return CustomListingCard() instead!
      children: List.generate(listing_list.length, (index) {
        return listing_list[index];
      }),
    ),
  );
}

Widget filterbutton() {
  return TextButton(
    child: Text(
      'Filters',
      textAlign: TextAlign.left,
    ),
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Colors.grey[400],
      primary: Colors.black,
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    ),
    onPressed: () {
      print('Pressed'); //TODO Filter according to what
    },
  );
}

Widget sortbutton() {
  return TextButton(
    child: Text('Sort'),
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Colors.grey[400],
      primary: Colors.black,
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    ),
    onPressed: () {
      print(
          'Pressed'); // TODO sort button?? why need to sort if we are gonna do all listing reports
    },
  );
}
