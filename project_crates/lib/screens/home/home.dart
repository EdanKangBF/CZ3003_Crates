import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/backend/profile_presenter.dart';
import 'package:flutter_application_1/models/user.dart';
import '../common/widgets.dart';
import '../common/theme.dart';
import 'package:flutter_application_1/models/Listing.dart';
import 'package:flutter_application_1/backend/home_presenter.dart';
import 'category_page.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String category = '';
  User userDetail;
  List<Listing> listings;
  List<User> userDetailList = [];
  bool dataLoadingStatus = false;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async{
    setState(() {
      dataLoadingStatus = true;
    });
    listings = await ListingData().getListings(category);
    // Sort list by date
    listings.sort((a,b) {
      var adate = a.postDateTime;
      var bdate = b.postDateTime;
      return -adate.compareTo(bdate);
    });

    for (int i=0;i<4;i++) {
      userDetail = await ProfilePresenter().retrieveUserProfile(listings[i].userID);
      userDetailList.add(userDetail);
    }
    setState(() {
      // listings = reversedList;
      listings = listings;
      userDetailList = userDetailList;
      dataLoadingStatus = false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: offWhite,
        body: dataLoadingStatus == false ?
        ListView(
            children: <Widget>[
              topCard(),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.fromLTRB(25,0,0,10),
                child: Text('Categories',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )
                ),
              ),
              CategoryList(context),
              SizedBox(height:15),
              Padding(
                padding: EdgeInsets.fromLTRB(25,0,0,10),
                child: Text('Latest',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )
                ),
              ),
              listings.isEmpty == true ? Text('No listings available',textAlign: TextAlign.center) : LatestList(userDetailList, listings),
              SizedBox(height:30),
            ]):Center(child: CircularProgressIndicator())
    );
  }
}


Widget topCard(){
  return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          child: Card(
              margin: EdgeInsets.zero,
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:60),
                  Center(
                    child: Text(
                      "CRATES",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 2,
                        color: offWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  SizedBox(height:30),
                  Padding(
                    padding: EdgeInsets.only(left:25),
                    child: Text('search',
                      style: TextStyle(
                        color: offWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
        Positioned(
          right: 45,
          left: 45,
          bottom:-20,
          child: Container(
            height: 50,
            child: TextField(
                decoration: InputDecoration(
                    focusedBorder :OutlineInputBorder(
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

      ]
  );

}

Widget CategoryList(context){
  return SizedBox(
      height:140,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
              height:140.0,
              width: 140.0,
              child:GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage('All Categories')));
                  },
                  child: Card(
                      color: Colors.grey[350],
                      margin: EdgeInsets.all(5),
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              child: Text('All',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
                              child: Image(
                                  image: AssetImage('assets/icons/groceries.png')
                              ),
                            )
                          ]
                      )
                  )
              )),
          Container(
              height:140.0,
              width: 140.0,
              child:GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage('Vegetables')));
                  },
                  child: Card(
                      color: Colors.grey[350],
                      margin: EdgeInsets.all(5),
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              child: Text('Vegetables',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
                              child: Image(
                                  image: AssetImage('assets/icons/broccoli.png')
                              ),
                            )
                          ]
                      )
                  )
              )),
          Container(
              height:140.0,
              width: 140.0,
              child:GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage('Canned Food')));
                  },
                  child: Card(
                      color: Colors.grey[350],
                      margin: EdgeInsets.all(5),
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              child: Text('Canned Food',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
                              child: Image(
                                  image: AssetImage('assets/icons/cream.png')
                              ),
                            )
                          ]
                      )
                  )
              )),
          Container(
              height:140.0,
              width: 140.0,
              child:GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage('Snacks')));
                  },
                  child: Card(
                      color: Colors.grey[350],
                      margin: EdgeInsets.all(5),
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              child: Text('Snacks',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
                              child: Image(
                                  image: AssetImage('assets/icons/snacks.png')
                              ),
                            )
                          ]
                      )
                  )
              )),
          Container(
              height:140.0,
              width: 140.0,
              child:GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage('Beverages')));
                  },
                  child: Card(
                      color: Colors.grey[350],
                      margin: EdgeInsets.all(5),
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              child: Text('Beverages',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
                              child: Image(
                                  image: AssetImage('assets/icons/can.png')
                              ),
                            )
                          ]
                      )
                  )
              )),
          Container(
              height:140.0,
              width: 140.0,
              child:GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage('Dairy Product')));
                  },
                  child: Card(
                      color: Colors.grey[350],
                      margin: EdgeInsets.all(5),
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              child: Text('Dairy Products',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
                              child: Image(
                                  image: AssetImage('assets/icons/food.png')
                              ),
                            )
                          ]
                      ))
              )),
          Container(
              height:140.0,
              width: 140.0,
              child:GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage('Dry Food')));
                  },
                  child: Card(
                      color: Colors.grey[350],
                      margin: EdgeInsets.all(5),
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              child: Text('Dry Food',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
                              child: Image(
                                  image: AssetImage('assets/icons/pistachio.png')
                              ),
                            )
                          ]
                      ))
              )),
        ],
      )
  );
}

Widget LatestList(List<User> userDetailList,List<Listing> listings){

  List<CustomListingCard> listing_list = [];

  // Get First 4 Newest Listings
  for(int i=0;i<4;i++){
    listing_list.add(
        CustomListingCard(listingID: listings[i].listingID, title: listings[i].listingTitle, owner: userDetailList[i].username, listingImg: listings[i].listingImage, ownerImg: userDetailList[i].imagePath));
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.count(
      shrinkWrap : true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2 ,
      scrollDirection: Axis.vertical,
      children: List.generate(listing_list.length,(index){
        return listing_list[index];
      }),
    ),
  );
}

