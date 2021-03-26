import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/NavigationBar.dart';
import '../common/theme.dart';
import '../common/widgets.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(2),
        backgroundColor: offWhite,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              topCard('assets/icons/default.png', 'leejunwei', 86),
              SizedBox(height: 50),
              TabBar(
                  tabs: [
                    Tab(text: 'Listings'),
                    Tab(text: 'Reviews'),
                  ],
                controller: _tabController,
                ),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                        child: Column(
                          children:[
                            Row(
                              children: [
                                ListingCard(title: "Old Town White Coffee", owner: "leejunwei", listingImg: 'assets/coffee.jpg', ownerImg: 'assets/icons/default.png'),
                                ListingCard(title: "Korean Spicy Noodles Samyang", owner: "Eggxactly", listingImg: 'assets/noodles.jpg', ownerImg: 'assets/icons/default.png'),
                              ],
                            ),
                            Row(
                              children: [
                                ListingCard(title: "Old Town White Coffee", owner: "leejunwei", listingImg: 'assets/coffee.jpg', ownerImg: 'assets/icons/default.png'),
                                ListingCard(title: "Korean Spicy Noodles Samyang", owner: "Eggxactly", listingImg: 'assets/noodles.jpg', ownerImg: 'assets/icons/default.png'),
                              ],
                            ),
                            Row(
                              children: [
                                ListingCard(title: "Old Town White Coffee", owner: "leejunwei", listingImg: 'assets/coffee.jpg', ownerImg: 'assets/icons/default.png'),
                                ListingCard(title: "Korean Spicy Noodles Samyang", owner: "Eggxactly", listingImg: 'assets/noodles.jpg', ownerImg: 'assets/icons/default.png'),
                              ],
                            ),
                          ]
                        )),
                    ListView(
                      padding:  EdgeInsets.all(8),
                      children: <Widget>[
                        reviewCard('freethings4u', 'assets/icons/default.png', 'very nice young man, thank you!', '5 days'),
                        reviewCard('freethings4u', 'assets/icons/default.png', 'very nice young man, thank you!', '5 days'),
                        reviewCard('freethings4u', 'assets/icons/default.png', 'very nice young man, thank you!', '5 days'),
                        reviewCard('freethings4u', 'assets/icons/default.png', 'very nice young man, thank you!', '5 days'),
                        reviewCard('freethings4u', 'assets/icons/default.png', 'very nice young man, thank you!', '5 days'),
                        SizedBox(height:20),
                      ],
                    ),
                  ],
                  controller: _tabController,
                ),
              ),

            ]));
  }
}

Widget reviewCard(reviewer, reviewerImg, review, time){
  return Container(
    height:100,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
            backgroundImage: AssetImage(reviewerImg),
            radius: 30,
            ),
            SizedBox(width:15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reviewer,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )
                ),
                Text(review,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    )
                ),
                Text(time + " ago",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    )
                ),
              ],
            )

          ]
        ),
      )
    )
  );
}

Widget topCard(ownerImg, username, n_reviews){
  return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 180,
          child: Card(
              margin: EdgeInsets.zero,
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(145, 110,0,0),
                    child: Text(
                      username,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: offWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:145),
                    child: Text(n_reviews.toString() + " reviews",
                      style: TextStyle(
                        color: offWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
        Positioned(
          right: 20,
          left: 290,
          bottom:-20,
          child: Container(
            height: 40,
            child: CustomCurvedButton(
              btnText: 'Edit',
              btnPressed: (){},
            )
          ),
        ),
        Positioned(
          left: 20,
          bottom: -40,
          child: CircleAvatar(
            backgroundImage: AssetImage(ownerImg),
            radius: 60,
          ),
        ),
      ]
  );

}