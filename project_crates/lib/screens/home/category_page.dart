import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import '../common/widgets.dart';
import '../common/theme.dart';
import 'package:flutter_application_1/models/Listing.dart';
import 'package:flutter_application_1/backend/home_presenter.dart';
import 'package:flutter_application_1/backend/profile_presenter.dart';

class CategoryPage extends StatefulWidget {

  CategoryPage (this.categoryName);
  final String categoryName;

  @override
  _CategoryPageState createState() =>  _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  String category;
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
      category = widget.categoryName;
    });
    listings = await ListingData().getListings(category);
    for (int i=0; i< listings.length;i++) {
      userDetail = await ProfilePresenter().retrieveUserProfile(listings[i].userID);
      userDetailList.add(userDetail);
    }
    setState(() {
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
              Container(
                color: primaryColor,
                alignment: Alignment(-1, -1),
                child: TextButton.icon(
                    icon: Icon(Icons.keyboard_backspace),
                    label: Text('Back', style: TextStyle(
                      color: offWhite,
                    )),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              topCard(),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.fromLTRB(25,0,0,10),
                child: Text(category,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )
                ),
              ),
              SizedBox(height:15),
              listings.isEmpty == true ? Text('No listings available',textAlign: TextAlign.center) : CategoryList(userDetailList, listings),
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

Widget CategoryList(List<User> userDetailList, List<Listing> listings) {

  List<CustomListingCard> listing_list = [];

  for(int i=0; i< listings.length;i++){
    listing_list.add(CustomListingCard(listingID: listings[i].listingID, title: listings[i].listingTitle, owner: userDetailList[i].username, listingImg: listings[i].listingImage, ownerImg: userDetailList[i].imagePath));
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
        })
    ),
  );
}